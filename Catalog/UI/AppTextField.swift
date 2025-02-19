//
//  AppTextField.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            Group {
                Text(placeholder)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                TextField("", text: $text)
                    .font(.footnote)
                    .padding(14)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .fontWeight(.light)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct AppTextView: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            Group {
                Text(placeholder)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .font(.footnote)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(14)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .fontWeight(.light)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    VStack {
        AppTextField(placeholder: "Descripción Game", text: .constant("Hola"))
        AppTextView(placeholder: "Descripción Game", text: .constant("Hola"))
    }
    
}
