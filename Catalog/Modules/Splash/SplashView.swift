//
//  SplashView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    
    init(coordinator: Coordinator<AppRoutePath>) {
        _viewModel = StateObject(wrappedValue: SplashViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Background(state: .loaded) {
            Color.blue.ignoresSafeArea()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.handleAction(.loaderCompleted)
            }
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .splash)
    AppRoutePath.appView(coordinator: coordinator)
}
