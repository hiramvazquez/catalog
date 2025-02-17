//
//  CustomError.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

enum CustomError: Error, Equatable {
    case general
    case invalidResponse
    
    public var errorMessage: String {
        switch self {
        case .general:
            return "Ha ocurrido un error general. Intente más tarde."
        case .invalidResponse:
            return "Ha ocurrido un error al conectarse al servidor."
        }
    }
}
