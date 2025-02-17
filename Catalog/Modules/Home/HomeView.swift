//
//  HomeView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    init(coordinator: Coordinator<AppRoutePath>) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Background {
            Color.blue.ignoresSafeArea()
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .splash)
    AppRoutePath.appView(coordinator: coordinator)
}
