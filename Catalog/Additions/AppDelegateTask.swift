//
//  AppDelegateTask.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import UIKit

typealias AppDelegateTask = UIResponder & UIApplicationDelegate

enum AppDelegateFactory {
    static func makeDefault() -> AppDelegateTask {
        return CompositeAppDelegateTasks(tasks: [
            DependencyInjectionAppDelegateTask() // Important: Should be the first task to avoid Dependency problems
        ])
    }
}

class CompositeAppDelegateTasks: AppDelegateTask {
    let tasks: [AppDelegateTask]
    
    init(tasks: [AppDelegateTask]) {
        self.tasks = tasks
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        tasks.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        tasks.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
}

class DependencyInjectionAppDelegateTask: AppDelegateTask {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DependenciesAssembler.shared.register()
        return true
    }
}
