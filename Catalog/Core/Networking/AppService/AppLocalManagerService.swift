//
//  AppLocalManagerService.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 18/02/25.
//

import Foundation
import SwiftData

protocol AppLocalManagerService {
    func retrieveAllGames() async throws -> [LocalGame]
    func storeAllGames(games: [Game]) async throws
}

final class LocalManagerService: AppLocalManagerService {
    private var modelContainer: ModelContainer?
    private var modelContext: ModelContext?
    
    init() {
        Task { @MainActor in
            self.modelContainer = try? ModelContainer(for: LocalGame.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            self.modelContext = modelContainer?.mainContext
        }
    }
    
    func retrieveAllGames() async -> [LocalGame] {
        guard let modelContext else { return [] }
        do {
            return try modelContext.fetch(FetchDescriptor<LocalGame>())
        } catch {
            return []
        }
    }
    
    func storeAllGames(games: [Game]) async throws {
        await removeBeforeStore()
        
        let localGames = games.map({ $0.toLocalGame() })
        do {
            for game in localGames {
                modelContext?.insert(game)
            }
            try saveContext()
        }
        catch {
            throw error
        }
        
        func removeBeforeStore() async {
            guard let modelContext else { return }
            let games = await retrieveAllGames()
            games.forEach({ modelContext.delete($0) })
        }
    }
    
    private func saveContext() throws {
        guard let modelContext = modelContext else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        do {
            try modelContext.save()
        } catch {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
}
