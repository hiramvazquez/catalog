//
//  Router.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

typealias Hash = Hashable & Identifiable

enum AppRoutePath: Hash {
    case splash
    case home
    
    static func appView(coordinator: Coordinator<AppRoutePath>) -> some View {
        RouterView(coordinator: coordinator) { route in
            switch route {
            case .splash:
                AnyView(SplashView(coordinator: coordinator))
            case .home:
                AnyView(HomeView(coordinator: coordinator))
            }
        }
    }
}

extension AppRoutePath {
    var id: String {
        UUID().uuidString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

