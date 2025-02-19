//
//  AppServiceManager.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine

struct EmptyData: Encodable {}

protocol ApiManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<E, Error> where E: Decodable
}
// Servicio global de llamada a la API
final class ManagerService: BaseService, ApiManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<E, any Error> where T : RequestParam, E: Decodable {
        return netWorkingManager.execute(parameters: request)
            .eraseToAnyPublisher()
    }
}
