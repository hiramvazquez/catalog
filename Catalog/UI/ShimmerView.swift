//
//  ShimmerView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1.0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.7), .clear]),
                               startPoint: .leading,
                               endPoint: .trailing)
                .mask(content)
                .offset(x: phase * 300)
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: phase)
            )
            .onAppear {
                phase = 1.0
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}

struct ShimmerView: View {
    var body: some View {
        Color.gray.opacity(0.5)
        .shimmer()
    }
}

#Preview {
    ShimmerView()
        .frame(width: 200, height: 40)
}
