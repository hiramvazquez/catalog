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
    case apiError(ApiError)
    
    struct ApiError: Decodable, Hashable {
        var message: ErrorMessage
        
        init(message: ErrorMessage) {
            self.message = message
        }
        
        enum CodingKeys: CodingKey {
            case message
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                self.message = try container.decode(ErrorMessage.self, forKey: .message)
            } catch {
                self.message = .GENERAL
            }
        }

        enum ErrorMessage: String, Decodable {
            case GENERAL
            
            var message: String {
                switch self {
                case .GENERAL:
                    return "Ha ocurrido un error general. Intente más tarde."
                }
            }
        }
    }
    
    public var errorMessage: String {
        switch self {
        case .apiError(let apiError):
            return apiError.message.message
        case .general:
            return "Ha ocurrido un error general. Intente más tarde."
        case .invalidResponse:
            return "Ha ocurrido un error al conectarse al servidor."
        }
    }
}

