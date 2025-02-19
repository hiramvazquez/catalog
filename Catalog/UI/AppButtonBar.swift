//
//  AppButtonBar.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import SwiftUI

struct AppButtonBar: View {
    let imageName: String
    let action: Action
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .font(.title)
                .foregroundStyle(.black, .gray.opacity(0.7))
        }
    }
}

#Preview {
    AppButtonBar(imageName: "trash.circle.fill", action: {})
}
