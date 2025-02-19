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
        Background(state: viewModel.state) {
            catalogList
        }
        .onAppear {
            viewModel.handle(.getCatalogFromCache)
        }
    }
    
    private var catalogList: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.filteredGames, id: \.self) { game in
                    GameCellView(game: game, onSelected: {
                        viewModel.handle(.onSelectGame(game))
                    })
                }
            }
            .searchable(text: $viewModel.searchText)
            .padding(.vertical)
        }
        .refreshable {
            viewModel.handle(.getCatalogAndSave)
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
