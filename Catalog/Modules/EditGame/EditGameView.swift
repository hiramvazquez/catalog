//
//  EditGameView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import SwiftUI

struct EditGameView: View {
    @StateObject var viewModel: EditGameViewModel
    
    init(coordinator: Coordinator<AppRoutePath>, game: Binding<LocalGame>, onCompleted: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: EditGameViewModel(coordinator: coordinator, game: game, onCompleted: onCompleted))
    }
    
    var body: some View {
        Background(state: .loaded()) {
            VStack(spacing: 20) {
                formView
                buttonView
            }
            .padding([.bottom, .horizontal])
        }
        .toolbarItem(placement: .principal, content: {
            Text("Editar juego")
                .fontWeight(.bold)
        })
    }
    
    private var formView: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    AppTextField(placeholder: "Nombre", text: $viewModel.game.title)
                    AppTextView(placeholder: "Descripción", text: $viewModel.game.short_description)
                    AppTextField(placeholder: "Lanzamiento", text: $viewModel.game.release_date)
                    AppTextField(placeholder: "Compañía", text: $viewModel.game.developer)
                    AppTextField(placeholder: "Editora", text: $viewModel.game.publisher)
                    AppTextField(placeholder: "Plataforma", text: $viewModel.game.platform)
                }
                .frame(maxWidth: .infinity, minHeight: geometry.size.height, alignment: .top)
            }
        }
    }
    
    private var buttonView: some View {
        Button {
            viewModel.handleAction(.onAcceptButtonPressed)
        } label: {
            Text("Aceptar")
                .padding(6)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .editGame(.constant(AppPreview.shared.game), {}))
    AppRoutePath.appView(coordinator: coordinator)
}
