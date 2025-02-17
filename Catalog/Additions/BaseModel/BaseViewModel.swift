//
//  BaseViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine
import SwiftUI

protocol BaseViewModelProtocol {
    func execute<T, E>(request: AppRequest<T>, completion: @escaping (E) -> Void) where T : RequestParam, E: Decodable
}

class BaseViewModel: ObservableObject, BaseViewModelProtocol {
    @Inject var appService: AppManagerService
    @ObservedObject var route: Coordinator<AppRoutePath>
    @Published var state: ViewState = .loaded
    
    enum ViewState {
        case loading
        case loaded
        case error(CustomError)
    }
    
    var cancellables = Set<AnyCancellable>()
    init(coordinator: Coordinator<AppRoutePath>) {
        self.route = coordinator
    }
}

extension BaseViewModel {
    func execute<T, E>(request: AppRequest<T>, completion: @escaping (E) -> Void) where T : RequestParam, E: Decodable {
        appService.execute(request: request)
            .map { $0.response.data }
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    guard let customError = error as? CustomError else { return }
                    self?.proccessError(error: customError)
                }
            } receiveValue: { data in
                completion(data)
            }
            .store(in: &cancellables)
    }
    
    private func proccessError(error: CustomError) {
        self.state = .error(error)
    }
}
