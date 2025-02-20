//
//  NetWorkingModule.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

struct NetWorkingModule: DependencyModule {
    func register() {
        Task { @MainActor in
            Dependency.register(NetworkingManager(), lifecycle: .singleton, as: NetworkingManagerService.self)
        }        
    }
}
