//
//  AppServiceManager.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine

struct EmptyData: Encodable {}

protocol AppManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<E, Error> where E: Decodable
}

final class ManagerService: BaseService, AppManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<E, any Error> where T : RequestParam, E: Decodable {
        return netWorkingManager.execute(parameters: request)
            .eraseToAnyPublisher()
    }
}
