//
//  AppService.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 21/02/25.
//

import Foundation

@MainActor
protocol AppManagerService {
    func execute<T, E>(request: AppRequest<T>) async throws -> E where T: RequestParam, E: Decodable, E: Sendable
}

final class AppService: AppManagerService {
    @Inject var apiService: NetworkingManagerService
    
    func execute<T, E>(request: AppRequest<T>) async throws -> E where T: RequestParam, E: Decodable, E: Sendable {
        do {
            let result: E = try await apiService.execute(parameters: request)
            return result
        } catch let error as CustomError {
            throw error
        } catch {
            throw CustomError.general
        }
    }
}
