//
//  BaseViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
protocol BaseViewModelProtocol: ObservableObject {
    func execute<T, E>(request: AppRequest<T>) async -> E? where T: RequestParam, E: Decodable, E: Sendable
}

typealias AlertModel = (alert: AlertType, action: Action)

class BaseViewModel: BaseViewModelProtocol {
    @Inject var apiService: NetworkingManagerService
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
    func execute<T, E>(request: AppRequest<T>) async -> E? where T : RequestParam, E : Decodable, E : Sendable {
        do {
            let result: E = try await apiService.execute(parameters: request)
            return result
        } catch let error as CustomError {
            showError(error: error)
            return nil
        } catch {
            showError(error: .general)
            return nil
        }
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
