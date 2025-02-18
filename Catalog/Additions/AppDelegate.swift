//
//  AppDelegate.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DependenciesAssembler.shared.register()
        return true
    }
}
