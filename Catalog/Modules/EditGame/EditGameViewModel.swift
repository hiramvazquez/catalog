//
//  EditGameViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import Foundation
import SwiftUI

final class EditGameViewModel: BaseViewModel {
    @Binding var game: LocalGame
    let onCompleted: Action
    
    enum ViewAction {
        case onAcceptButtonPressed
    }
    
    func handleAction(_ action: ViewAction) {
        switch action {
        case .onAcceptButtonPressed:
            onCompleted()
        }
    }
    
    init(coordinator: Coordinator<AppRoutePath>, game: Binding<LocalGame>, onCompleted: @escaping Action) {
        self._game = game
        self.onCompleted = onCompleted
        super.init(coordinator: coordinator)
    }
}
