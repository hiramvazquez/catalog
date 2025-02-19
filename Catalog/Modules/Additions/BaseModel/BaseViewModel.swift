//
//  BaseViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine
import SwiftUI

protocol BaseViewModelProtocol: ObservableObject {
    func execute<T, E>(request: AppRequest<T>, completion: @escaping (E) -> Void) where T : RequestParam, E: Decodable
}

typealias AlertModel = (alert: AlertType, action: Action)

class BaseViewModel: BaseViewModelProtocol {
    @Inject var apiService: ApiManagerService
    var localDataBase = LocalDataBaseManagerService.shared
    
    @ObservedObject var route: Coordinator<AppRoutePath>
    @Published var state: ViewState = .loaded()
    var cancellables = Set<AnyCancellable>()
    
    enum ViewState {
        case loading
        case loaded(AlertModel? = nil)
        case error(CustomError, Action)
    }
    
    init(coordinator: Coordinator<AppRoutePath>) {
        self.route = coordinator
    }
    
    func onErrorAction() {
        fatalError("Implementar onErrorAction en cada viewModel")
    }
}

extension BaseViewModel {
    // llamada global a la API
    func execute<T, E>(request: AppRequest<T>, completion: @escaping (E) -> Void) where T : RequestParam, E: Decodable {
        apiService.execute(request: request)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    guard let customError = error as? CustomError else { return }
                    self?.showError(error: customError)
                }
            } receiveValue: { data in
                completion(data)
            }
            .store(in: &cancellables)
    }
    
    func showError(error: CustomError) {
        self.state = .error(error, {
            self.onErrorAction()
        })
    }
    
    func removeAlertView() {
        self.state = .loaded()
    }
}
