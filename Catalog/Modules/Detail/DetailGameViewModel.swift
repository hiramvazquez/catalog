//
//  DetailGameViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

final class DetailGameViewModel: BaseViewModel {
    @Published var game: LocalGame
    
    enum Action {
        case onRemoveGameButtonPressed
        case onEditGameButtonPressed
        case onVisitButtonPressed
    }
    
    func handleAction(_ action: Action) {
        switch action {
        case .onRemoveGameButtonPressed:
            removeGameAction()
        case .onEditGameButtonPressed:
            editGameAction()
        case .onVisitButtonPressed:
            openURLGameAction()
        }
    }
    
    init(coordinator: Coordinator<AppRoutePath>, game: LocalGame) {
        self.game = game
        super.init(coordinator: coordinator)
    }
    
    override func onErrorAction() {
        
    }
}

extension DetailGameViewModel {
    private func removeGameAction() {
        self.state = .loaded((.removeGame, {
            removeGame()
        }))
        
        func removeGame() {
            self.removeAlertView()
            Task {
                do {
                    try localDataBase.remove(game)
                } catch {}
                self.route.pop()
            }
        }
    }
    
    private func editGameAction() {
        let gameBinding = Binding(
            get: { self.game },
            set: { self.game = $0 }
        )
        route.presentSheet(.editGame(gameBinding, {
            self.route.removeSheet()
        }))
    }
    
    private func openURLGameAction() {
        guard let urlGame = game.gameURL else { return }
        UIApplication.shared.open(urlGame)
    }
}
