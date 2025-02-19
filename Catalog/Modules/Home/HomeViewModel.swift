//
//  HomeViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class HomeViewModel: BaseViewModel {
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
        case getCatalogFromCache
        case onSelectGame(LocalGame)
    }
    
    @MainActor
    func handle(_ action: Action) {
        switch action {
        case .getCatalogAndSave:
            getCatalogAndSaveAction()
        case .onSelectGame(let game):
            navigateToGameDetail(game: game)
        case .getCatalogFromCache:
            if gameList.count > 0 {
                Task {
                    await getCatalogFromCacheAction()
                }
            }
        }
    }
    
    override init(coordinator: Coordinator<AppRoutePath>) {
        super.init(coordinator: coordinator)
        state = .loading
        handle(.getCatalogAndSave)
    }
    
    override func onErrorAction() {}
}

extension HomeViewModel {
    private func getCatalogAndSaveAction() {
        let request = AppRequest(request: GameListRequest())
        Task {
            if let games: [Game] = await execute(request: request) {
                await storeAllGamesAction(games)
                await self.getCatalogFromCacheAction()
                self.state = .loaded()
            }
        }
        
        func storeAllGamesAction(_ gameList: [Game]) async {
            do {
                try localDataBase.addItems(gameList.map({ $0.toLocalGame() }))
            } catch { }
        }
    }
    
    private func getCatalogFromCacheAction() async {
        do {
            self.gameList = try localDataBase.fetchAll(ofType: LocalGame.self).sorted { $0.title < $1.title }
        } catch {}
    }
    
    private func navigateToGameDetail(game: LocalGame) {
        route.push(.detailGame(game))
    }    
}
