//
//  CatalogApp.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

@main
struct CatalogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .splash)
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppRoutePath.appView(coordinator: coordinator)
            }
        }
    }
}
