//
//  AppServiceManager.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine

protocol AppManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<AppResponse<E>, Error>
}

final class ManagerService: BaseService, AppManagerService {
    func execute<T, E>(request: AppRequest<T>) -> AnyPublisher<AppResponse<E>, any Error> where T : Encodable, E : Decodable {
        return netWorkingManager.execute(parameters: request)
            .eraseToAnyPublisher()
    }
}
