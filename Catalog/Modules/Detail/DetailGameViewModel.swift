//
//  DetailGameViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class DetailGameViewModel: BaseViewModel {
    @Published var game: LocalGame
    
    init(coordinator: Coordinator<AppRoutePath>, game: LocalGame) {
        self.game = game
        super.init(coordinator: coordinator)
    }
}
