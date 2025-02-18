//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    @Inject private var localService: AppLocalManagerService
    @Published var gameList: [Game] = []
    
    enum Action {
        case getCatalogAndSave
        case onSelectGame(Game)
    }
    
    func handle(_ action: Action) {
        switch action {
        case .getCatalogAndSave:
            getCatalogAndSaveAction()
        case .onSelectGame(let game):
            navigateToGameDetail(game: game)
        }
    }
    
    override init(coordinator: Coordinator<AppRoutePath>) {
        super.init(coordinator: coordinator)
        state = .loading
        handle(.getCatalogAndSave)
    }
    
    override func onErrorAction() {
        
    }
}

extension HomeViewModel {
    private func getCatalogAndSaveAction() {
        let request = AppRequest(request: GameListRequest())
        execute(request: request) { [weak self] gameList in
            Task {
                try await storeGameReturned(games: gameList)
                self?.gameList = gameList
                self?.state = .loaded
            }
        }
        
        func storeGameReturned(games: [Game]) async throws {
            do {
                try await localService.storeAllGames(games: games)
            }
            catch {
                throw NSError(domain: "", code: 0, userInfo: nil)
            }
        }
    }
    
    private func navigateToGameDetail(game: Game) {
        route.push(.detailGame(game))
    }    
}
