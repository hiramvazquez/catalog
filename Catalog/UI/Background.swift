//
//  Background.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct Background<Content: View>: View {
    @ViewBuilder let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(height: 0)
                    .background(.clear)
                content
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        Background {
            Text("Hola")
        }
    }
}
