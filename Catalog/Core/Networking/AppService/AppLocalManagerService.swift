//
//  AppLocalManagerService.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 18/02/25.
//

import Foundation
import SwiftData

final class LocalDataBaseManagerService {
    private var modelContainer: ModelContainer
    private var modelContext: ModelContext
    @MainActor
    static let shared = LocalDataBaseManagerService()
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: LocalGame.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func addItems<T: PersistentModel>(_ items: [T]) throws {
        try removeAll(ofType: T.self)
        for item in items {
            modelContext.insert(item)
        }
        try modelContext.save()
    }
    
    func addItem<T: PersistentModel>(_ item: T) throws {
        modelContext.insert(item)
        try modelContext.save()
    }
    
    func fetchAll<T: PersistentModel>(ofType type: T.Type) throws -> [T] {
        try modelContext.fetch(FetchDescriptor<T>())
    }
    
    func remove<T: PersistentModel>(_ item: T) throws {
        modelContext.delete(item)
        try modelContext.save()
    }
    
    func removeAll<T: PersistentModel>(ofType type: T.Type) throws {
        try modelContext.delete(model: type)
        try modelContext.save()
    }
}
