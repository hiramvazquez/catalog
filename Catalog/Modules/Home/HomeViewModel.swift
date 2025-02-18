//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    @Published var gameList: [Game] = []
    
    enum Action {
        case getCatalog
        case onSelectGame(Game)
    }
    
    func handle(_ action: Action) {
        switch action {
        case .getCatalog:
            getCatalogAction()
        case .onSelectGame(let game):
            navigateToGameDetail(game: game)
        }
    }
    
    override init(coordinator: Coordinator<AppRoutePath>) {
        super.init(coordinator: coordinator)
        state = .loading
        handle(.getCatalog)
    }
    
    override func onErrorAction() {
        
    }
}

extension HomeViewModel {
    private func getCatalogAction() {
        let request = AppRequest(request: GameListRequest())
        execute(request: request) { [weak self] gameList in
            self?.gameList = gameList
            self?.state = .loaded
        }
    }
    
    private func navigateToGameDetail(game: Game) {
        route.push(.detailGame(game))
    }
}
