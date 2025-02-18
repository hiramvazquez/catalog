//
//  NetWorkingModule.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

struct NetWorkingModule: DependencyModule {
    func register() {
        Dependency.register(NetworkingManager(), lifecycle: .singleton, as: NetworkingManagerService.self)
        Dependency.register(ManagerService(), lifecycle: .singleton, as: AppManagerService.self)
        Dependency.register(LocalManagerService(), lifecycle: .singleton, as: AppLocalManagerService.self)
    }
}
