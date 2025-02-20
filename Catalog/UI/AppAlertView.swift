//
//  AppAlertView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 18/02/25.
//

import SwiftUI

struct AppAlertView: View {
    let alert: AlertModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            VStack(spacing: 30) {
                Group {
                    VStack(spacing: 10) {
                        Text(alert.0.model.title)
                            .font(.title2)
                        Text(alert.0.model.message)
                    }
                }
                .foregroundColor(.black)
                Button(action: alert.1) {
                    Text("Aceptar")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    AppAlertView(alert: (.removeGame, {}))
}
