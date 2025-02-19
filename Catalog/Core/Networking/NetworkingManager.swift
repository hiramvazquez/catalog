//
//  NetworkingManager.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Combine
import Foundation

@MainActor
protocol NetworkingManagerService {
    func execute<E, T>(parameters: AppRequest<E>) async throws -> T where E: RequestParam, T: Decodable
}

final class NetworkingManager: NSObject, URLSessionDelegate, NetworkingManagerService {
    func execute<E, T>(parameters: AppRequest<E>) async throws -> T where E: RequestParam, T: Decodable {
        let endPoint = parameters.endPoint()
        
        guard let route = endPoint.resource.route else {
            throw CustomError.general
        }
        
        var request = URLRequest(url: route)
        request.httpMethod = endPoint.resource.method.rawValue
        
        // Agregar headers
        endPoint.resource.header.defaults.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Agregar parámetros si existen
        if let params = parameters.toParams() {
            request.httpBody = try JSONEncoder().encode(params)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Verificar la respuesta HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                throw CustomError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                return try JSONDecoder().decode(T.self, from: data)
            default:
                do {
                    let decodedError = try JSONDecoder().decode(CustomError.ApiError.self, from: data)
                    throw CustomError.apiError(decodedError)
                } catch {
                    throw error
                }
            }
        } catch {
            throw CustomError.invalidResponse
        }
    }
}
