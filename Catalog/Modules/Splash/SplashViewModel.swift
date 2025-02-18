//
//  SplashViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class SplashViewModel: BaseViewModel {
    enum Action {
        case loaderCompleted
    }
    
    func handleAction(_ action: Action) {
        switch action {
        case .loaderCompleted:
            navigateToHomeAction()
        }
    }
}

extension SplashViewModel {
    private func navigateToHomeAction() {
        route.setRoot(root: .home)
    }
}
