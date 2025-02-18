//
//  AlertModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 18/02/25.
//

import Foundation

enum AlertType: Equatable {
    case removeGame
    
    struct AlertModel {
        let title: String
        let message: String
    }
    
    var model: AlertModel {
        switch self {
            case .removeGame:
            .init(
                title: "¿Estás seguro?",
                message: "¿Deseas eliminar el juego?"
            )
        }
    }
}
