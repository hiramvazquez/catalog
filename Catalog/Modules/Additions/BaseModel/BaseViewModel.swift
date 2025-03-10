//
//  BaseViewModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

@MainActor
protocol BaseViewModelProtocol: ObservableObject {
    func execute<T, E>(request: AppRequest<T>) async -> E? where T: RequestParam, E: Decodable, E: Sendable
}

typealias AlertModel = (alert: AlertType, action: Action)

class BaseViewModel: BaseViewModelProtocol {
    @Inject var appService: AppManagerService
    var localDataBase = LocalDataBaseManagerService.shared
    
    @ObservedObject var route: Coordinator<AppRoutePath>
    @Published var state: ViewState = .loaded()
    
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
            let result: E = try await appService.execute(request: request)
            return result
        } catch let error as CustomError {
            showError(error: error)
        } catch {
            showError(error: .general)
        }
        return nil
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
