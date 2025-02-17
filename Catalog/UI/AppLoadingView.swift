//
//  AppLoadingView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct AppLoadingView: View {
    var gradient: AngularGradient
    @State private var isLoading = false
    
    init() {
        self.gradient = AngularGradient(
            gradient: Gradient(colors: [Color.gray]),
            center: .center,
            startAngle: .degrees(220),
            endAngle: .degrees(0))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Group {
                Circle()
                    .trim(from: 0, to: 0.6)
                    .stroke(
                        gradient,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round
                        )
                    )
                    .overlay {
                        Circle()
                            .stroke(
                                Color.gray.opacity(0.09),
                                lineWidth: 2
                            )
                    }
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
            }
            .frame(width: 60, height: 60)
        }
        .transition(.opacity)
        .task {
            self.isLoading = true
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
            }
        }
    }
}

#Preview {
    AppLoadingView()
}
