//
//  AppErrorView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct AppErrorView: View {
    let error: CustomError
    let action: Action
    
    var body: some View {
        Background(state: .loaded()) {
            contentView
        }
    }
    
    var contentView: some View {
        Group {
            ContentUnavailableView {
                Label {
                    Text("Error")
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.vertical, 80)
                }
            } description: {
                VStack {
                    Text(error.errorMessage)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
                    Spacer()
                    
                    Button {
                        action()
                    } label: {
                        Text("Aceptar")
                    }
                }
            }
        }
        .foregroundStyle(.gray)
        .padding()
    }
}

#Preview {
    AppErrorView(error: .general, action: {})
}
