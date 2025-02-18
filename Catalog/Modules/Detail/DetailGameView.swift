//
//  DetailGameView.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import SwiftUI

struct DetailGameView: View {
    @StateObject var viewModel: DetailGameViewModel
    @State var showDetailAnimated: Bool = false
    
    init(coordinator: Coordinator<AppRoutePath>, game: LocalGame) {
        _viewModel = StateObject(wrappedValue: DetailGameViewModel(coordinator: coordinator, game: game))
    }
    
    var body: some View {
        Background(state: viewModel.state) {
            contentView
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            withAnimation {
                showDetailAnimated = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.handleAction(.onRemoveGameButtonPressed)
                } label: {
                    imageBack(name: "trash")
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            headerView
            descriptionView()
                .offset(y: showDetailAnimated ? -100 : 0)
                .opacity(showDetailAnimated ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: showDetailAnimated)
            Spacer()
        }
    }
    
    private var headerView: some View {
        ZStack(alignment: .bottom) {
            if let url = viewModel.game.imageURL {
                AppAsyncImage(imageURL: url, imageDefault: Image(.iconGamePreview))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
            }
            gradientView
            titleView
        }
    }
    
    private var gradientView: some View {
        LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.4), .white.opacity(0.8), .white]),
                       startPoint: .top,
                       endPoint: .bottom)
        .frame(height: 300)
    }
    
    private var titleView: some View {
        Text(viewModel.game.title)
            .foregroundStyle(Color.black)
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .padding(.bottom, 100)
    }
    
    private func descriptionView() -> some View {
        let columns: [GridItem] = Array(repeating: .init(.fixed(150)), count: 2)
        return VStack {
            Group {
                Text(viewModel.game.short_description)
                    .padding(.bottom)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    verticalInfo(header: "Lanzamiento", info: viewModel.game.release_date)
                    verticalInfo(header: "Compañía", info: viewModel.game.developer)
                    verticalInfo(header: "Editora", info: viewModel.game.publisher)
                    verticalInfo(header: "Plataforma", info: viewModel.game.platform)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(.subheadline)
            .foregroundStyle(Color.black)
            .fontWeight(.regular)
        }
        .padding(.horizontal)
    }
    
    private func verticalInfo(header: String, info: String) -> some View {
        VStack(spacing: 10) {
            Text(header)
                .font(.footnote)
                .fontWeight(.bold)
            Text(info)
                .font(.footnote)
                .minimumScaleFactor(0.8)
        }
        .frame(width: 100, height: 60)
        .padding()
        .background( backgroundColor )
        .cornerRadius(8)
    }
    
    private var backgroundColor: some View {
        Color.teal
    }
}

#Preview {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .detailGame(AppPreview.shared.game))
    DetailGameView(coordinator: coordinator, game: AppPreview.shared.game)
}
