//
//  Background.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct Background<Content: View>: View {
    let state: BaseViewModel.ViewState
    @ViewBuilder let content: Content
    
    init(state: BaseViewModel.ViewState, @ViewBuilder _ content: () -> Content) {
        self.state = state
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(height: 0)
                    .background(.clear)
                switch state {
                case .loading:
                    AppLoadingView()
                case .error(let error, let action):
                    AppErrorView(error: error, action: action)
                case .loaded:
                    content
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        Background(state: .loading) {
            Text("Hola")
        }
    }
}
