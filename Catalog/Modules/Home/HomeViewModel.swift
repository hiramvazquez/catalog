//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class HomeViewModel: BaseViewModel {
    @Inject private var localService: AppLocalManagerService
    @Published var gameList: [LocalGame] = []
    @Published var searchText = ""
    var filteredGames: [LocalGame] {
        guard !searchText.isEmpty else { return gameList }
        return gameList.filter { game in
            game.title.lowercased().contains(searchText.lowercased()) ||
            game.short_description.lowercased().contains(searchText.lowercased())
        }
    }
    
    enum Action {
        case getCatalogAndSave
        case onSelectGame(LocalGame)
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
            guard let self = self else { return }
            Task {
                do {
                    try await storeGameReturned(games: gameList)
                    self.gameList = try await self.localService.retrieveAllGames().sorted(by: { $0.title < $1.title })
                } catch {
                    self.gameList = []
                }
                self.state = .loaded
            }
        }
        
        func storeGameReturned(games: [Game]) async throws {
            do {
                try await localService.storeAllGames(games: games)
            }
            catch {
                throw error
            }
        }
    }
    
    private func navigateToGameDetail(game: LocalGame) {
        route.push(.detailGame(game))
    }    
}
