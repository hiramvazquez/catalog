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
            case .error(_):
                EmptyView()
            case .loaded:
                catalogList
            }
        }
    }
    
    private var catalogList: some View {
        List {
            ForEach(viewModel.gameList, id: \.self) { game in
                Text(game.title)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Catálogo")
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .home)
    AppRoutePath.appView(coordinator: coordinator)
}
