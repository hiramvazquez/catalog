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
    
    func retrieveAllGames() async throws -> [LocalGame] {
        do {
            return try modelContext?.fetch(FetchDescriptor<LocalGame>()) ?? []
        } catch {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
    
    func storeAllGames(games: [Game]) async throws {
        removeBeforeStore()
        
        let localGames = games.map({ $0.toLocalGame() })
        do {
            for game in localGames {
                try await storeLocalGame(game: game)
            }
        }
        catch {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        
        func removeBeforeStore() {
            modelContext?.deletedModelsArray.forEach({ $0.modelContext?.delete($0) })
        }
    }
    
    private func storeLocalGame(game: LocalGame) async throws {
        guard let modelContext = modelContext else {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        modelContext.insert(game)
        do {
            try modelContext.save()
            print("Game \(game.title) saved")
        } catch {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
    }
}
