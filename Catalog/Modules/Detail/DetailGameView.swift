//
//  DetailGameView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct DetailGameView: View {
    @StateObject var viewModel: DetailGameViewModel
    @State private var animateContent = false
    
    init(coordinator: Coordinator<AppRoutePath>, game: LocalGame) {
        _viewModel = StateObject(wrappedValue: DetailGameViewModel(coordinator: coordinator, game: game))
    }
    
    var body: some View {
        Background(state: viewModel.state) {
            contentView
        }
        .toolbarItem(placement: .navigationBarTrailing) {
            AppButtonBar(imageName: "trash.circle.fill", action: {
                viewModel.handleAction(.onRemoveGameButtonPressed)
            })
        }
        .toolbarItem(placement: .navigationBarTrailing) {
            AppButtonBar(imageName: "pencil.circle.fill", action: {
                viewModel.handleAction(.onEditGameButtonPressed)
            })
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            animateContent = true
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            headerView
            descriptionView.padding()
        }
    }
    
    private var headerView: some View {
        ZStack(alignment: .bottom) {
            if let url = viewModel.game.imageURL {
                AppAsyncImage(imageURL: url, imageDefault: Image(.iconGamePreview))
            }
            gradientView
        }
    }
    
    private var gradientView: some View {
        LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.3), .white]),
                       startPoint: .top,
                       endPoint: .bottom)
        .frame(height: 200)
    }
    
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.game.title)
                .font(.title)
                .bold()
            Text(viewModel.game.short_description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                DetailRow(label: "Fecha de Lanzamiento", value: viewModel.game.release_date)
                DetailRow(label: "Plataforma", value: viewModel.game.platform)
                DetailRow(label: "Editora", value: viewModel.game.publisher)
                DetailRow(label: "Compañía", value: viewModel.game.developer)
                DetailRow(label: "Género", value: viewModel.game.genre)
                DetailRow(label: "Página web", value: viewModel.game.game_url)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .opacity(animateContent ? 1 : 0)
        .offset(y: animateContent ? -50 : 0)
        .animation(.easeOut(duration: 1).delay(0.5), value: animateContent)
    }
    
    private func DetailRow(label: String, value: String) -> some View {
        return HStack {
            Group {
                Text(label + ":")
                    .bold()
                Spacer()
                if isURL(value: value) {
                    Button {
                        viewModel.handleAction(.onVisitButtonPressed)
                    } label: {
                        Text("Visitar")
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Text(value)
                        .foregroundColor(.blue)
                }
            }
            .font(.subheadline)
        }
        
        func isURL(value: String) -> Bool {
            value.contains("https://")
        }
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .detailGame(AppPreview.shared.game))
    AppRoutePath.appView(coordinator: coordinator)
}
