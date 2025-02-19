//
//  DetailGameViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class DetailGameViewModel: BaseViewModel {
    @Published var game: LocalGame
    @Published var showEditGameView: Bool = false
    
    enum Action {
        case onRemoveGameButtonPressed
    }
    
    func handleAction(_ action: Action) {
        switch action {
        case .onRemoveGameButtonPressed:
            removeGameAction()
        }
    }
    
    init(coordinator: Coordinator<AppRoutePath>, game: LocalGame) {
        self.game = game
        super.init(coordinator: coordinator)
    }
    
    override func onErrorAction() {
        state = .loaded()
    }
}

extension DetailGameViewModel {
    private func removeGameAction() {
        self.state = .loaded((.removeGame, {
            self.removeAlertView()
            Task {
                self.removeGame()
                self.route.pop()
            }
        }))
    }
    
    private func removeGame() {
        do {
            try localDataBase.remove(game)
        } catch {}
    }
}
