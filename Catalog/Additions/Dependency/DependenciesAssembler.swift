//
//  DependenciesAssembler.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

protocol DependencyModule {
    func register()
}

final class DependenciesAssembler {
    static let shared = DependenciesAssembler()
    
    private let modules: [DependencyModule] = [
        NetWorkingModule()
    ]
    
    func register() {
        modules.forEach { $0.register() }
    }
}
