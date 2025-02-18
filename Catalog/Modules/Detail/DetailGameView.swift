//
//  DetailGameView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct DetailGameView: View {
    @StateObject var viewModel: DetailGameViewModel
    
    init(coordinator: Coordinator<AppRoutePath>, game: Game) {
        _viewModel = StateObject(wrappedValue: DetailGameViewModel(coordinator: coordinator, game: game))
    }
    
    var body: some View {
        Background(state: .loaded) {
            contentView
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private var contentView: some View {
        VStack {
            if let url = viewModel.game.imageURL {
                AppAsyncImage(imageURL: url, imageDefault: Image(.iconGamePreview))
            }
            VStack {
                titleView
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
    
    private var titleView: some View {
        Text(viewModel.game.title)
            .font(.title)
            .fontWeight(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .detailGame(AppPreview.shared.game))
    DetailGameView(coordinator: coordinator, game: AppPreview.shared.game)
}
