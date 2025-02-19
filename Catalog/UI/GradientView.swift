//
//  GradientView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    GradientView()
}
