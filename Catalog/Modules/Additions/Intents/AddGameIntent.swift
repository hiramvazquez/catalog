//
//  AddGameIntent.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 20/02/25.
//

import Foundation
import AppIntents
/*
struct AddGameIntent: AppIntent {
    let localDatabaseManger = LocalDataBaseManagerService.shared
    
    static let title: LocalizedStringResource = "Crear Juego"
    
    @Parameter(title: "Nombre", requestValueDialog: "Cual es el nombre del Juego?")
    var nombre: String
    
    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let localGame = AppPreview.shared.game
        localGame.title = nombre
        try localDatabaseManger.addItem(localGame)
        return .result(value: "Nuevo juego: \(nombre)")
    }
}
*/
