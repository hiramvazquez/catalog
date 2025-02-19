//
//  SplashView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    @State private var scaleEffect = 0.6
    
    init(coordinator: Coordinator<AppRoutePath>) {
        _viewModel = StateObject(wrappedValue: SplashViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Background(state: .loaded()) {
            GradientView()
            contentView
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.handleAction(.loaderCompleted)
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
                .scaleEffect(scaleEffect)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        scaleEffect = 1.0
                    }
                }
            
            Text("Catalog App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .splash)
    AppRoutePath.appView(coordinator: coordinator)
}
