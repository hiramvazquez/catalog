//
//  AppAsyncImage.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

struct AppAsyncImage: View {
    var imageURL: URL
    var imageDefault: Image?
    
    var body: some View {
        CacheAsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty, .failure(_):
                ShimmerView()
            case .success(let image):
                image
                    .resizable()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    AppAsyncImage(imageURL: URL(string: "https://www.freetogame.com/g/582/thumbnail.jpg")!, imageDefault: nil)
        .frame(width: 300, height: 200)
}

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(animation: .default),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ){
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

private class ImageCache {
    static nonisolated(unsafe) private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
