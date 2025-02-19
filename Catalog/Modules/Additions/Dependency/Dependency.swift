//
//  Dependency.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

@propertyWrapper
class Inject<T> {
    private var value: T?
    
    var wrappedValue: T {
        get {
            if let value = value {
                return value
            } else {
                value = storage.resolve(T.self)
                return value!
            }
        }
    }
}

enum Lifecycle {
    case singleton
    case instance
}

class Dependency {
    static func register<T>(_ instancer: @autoclosure @escaping () -> T, lifecycle: Lifecycle, as type: T.Type = T.self) {
        storage.register(instancer, lifecycle: lifecycle, type: type)
    }
    
    static func resolve<T>(_ type: T.Type = T.self) -> T {
        storage.resolve(type)
    }
}

nonisolated(unsafe) private let storage: Storage = .init()
private class Storage {
    var instances: [String: Any] = [:]
    var instancers: [String: () -> Any] = [:]
    
    func register<T>(_ instancer: @escaping () -> T, lifecycle: Lifecycle, type: T.Type = T.self) {
        let typeReflection = String(reflecting: type)
        
        guard instances[typeReflection] == nil, instancers[typeReflection] == nil else { return }
        switch lifecycle {
        case .singleton:
            instances[typeReflection] = instancer()
        case .instance:
            instancers[typeReflection] = instancer
        }
    }
    
    func resolve<T>(_ type: T.Type = T.self) -> T {
        let typeReflection = String(reflecting: type)
        
        if let singleton = instances[typeReflection] as? T {
            return singleton
        }
        
        if let instance = instancers[typeReflection], let newInstance = instance() as? T {
            return newInstance
        }
        
        fatalError("Dependency not registered")
    }
}
