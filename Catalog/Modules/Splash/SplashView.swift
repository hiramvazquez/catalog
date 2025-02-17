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
        Background {
            Color.red.ignoresSafeArea()
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .splash)
    AppRoutePath.appView(coordinator: coordinator)
}
