//
//  HomeView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(coordinator: Coordinator<AppRoutePath>) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Background {
            switch viewModel.state {
            case .loading:
                AppLoadingView()
            case .error(let error):
                AppErrorView(error: error)
            case .loaded:
                catalogList()
            }
        }
    }
    
    private func catalogList() -> some View {
        return ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.gameList, id: \.self) { game in
                    GameCellView(game: game, onSelected: {
                        viewModel.handle(.onSelectGame(game))
                    })
                }
            }
            .padding(.vertical)
        }
        .refreshable {
            viewModel.handle(.getCatalog)
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text("Catálogo")
                    .font(.title)
                    .fontWeight(.black)
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .home)
    AppRoutePath.appView(coordinator: coordinator)
}
