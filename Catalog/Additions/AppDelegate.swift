//
//  AppDelegate.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    private let appDelegateTask: AppDelegateTask = AppDelegateFactory.makeDefault()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        _ = appDelegateTask.application?(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}
