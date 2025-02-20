//
//  GameCellView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct GameCellView: View {
    let game: LocalGame
    let onSelected: Action
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let url = game.imageURL {
                AppAsyncImage(imageURL: url, imageDefault: Image(.iconGamePreview))
            }
            titleView
        }
        .frame(height: 200)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding(.horizontal)
        .onTapGesture {
            onSelected()
        }
    }
    
    private var titleView: some View {
        Text(game.title)
            .foregroundStyle(.white)
            .font(.body)
            .fontWeight(.heavy)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
            .padding([.horizontal, .bottom])
            .padding(.top, 50)
            .background {
                gradientView
            }
    }
    
    private var gradientView: some View {
        LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.1), .black.opacity(0.5), .black.opacity(0.8)]),
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

#Preview {
    GameCellView(game: AppPreview.shared.game, onSelected: {})
}
