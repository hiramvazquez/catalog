//
//  AppErrorView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct AppErrorView: View {
    let error: CustomError
    
    var body: some View {
        Background {
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
                    }
            } description: {
                Text(error.errorMessage)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.vertical)
            }
        }
        .foregroundStyle(.gray)
        .padding()
    }
}

#Preview {
    AppErrorView(error: .general)
}
