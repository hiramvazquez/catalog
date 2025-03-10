//
//  Coordinator.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI
import Combine

extension View {
    func toolbarItem<T: View>(
        placement: ToolbarItemPlacement = .navigationBarTrailing,
        @ViewBuilder content: @escaping () -> T
    ) -> some View {
        modifier(ToolbarItemModifier(placement: placement, content: content))
    }
}
struct ToolbarItemModifier<T: View>: ViewModifier {
    let placement: ToolbarItemPlacement
    let content: () -> T

    func body(content: Content) -> some View {
        content
        .toolbar {
            ToolbarItem(placement: placement) {
                self.content()
            }
        }
    }
}

enum NavigationState {
    case main
    case modal
}

typealias NavigationPaths<T: Hashable> = (root: T, paths: [T])

final class Coordinator<T: Hashable>: ObservableObject {
    @Published var navigationState: NavigationState {
        didSet {
            withAnimation {
                isModalPresented = navigationState == .modal
            }
        }
    }
    @Published var navigationMain: NavigationPaths<T>
    @Published var navigationModal: NavigationPaths<T>?
    @Published var isModalPresented: Bool = false
    @Published var isSheetPresented: Bool = false
    @Published var sheet: T?
    
    init(initialRoot: T) {
        self.navigationMain = (root: initialRoot, paths: [])
        self.navigationState = .main
    }
    
    func setRoot(root: T) {
        self.navigationMain = (root: root, paths: [])
        self.navigationState = .main
    }
    
    func push(_ path: T) {
        switch navigationState {
        case .main:
            navigationMain.paths.append(path)
        case .modal:
            navigationModal?.paths.append(path)
        }
    }

    func pop() {
        switch navigationState {
        case .main:
            guard !navigationMain.paths.isEmpty else { return }
            navigationMain.paths.removeLast()
        case .modal:
            guard !(navigationModal?.paths.isEmpty ?? true) else { return }
            navigationModal?.paths.removeLast()
        }
    }
    
    func popToRoot() {
        switch navigationState {
        case .main:
            navigationMain.paths.removeAll()
        case .modal:
            navigationModal?.paths.removeAll()
        }
    }
    
    func popTo(to: T) {
        switch navigationState {
        case .main:
            guard let found = navigationMain.paths.firstIndex(where: { $0 == to }) else { return }
            let numToPop = (found..<navigationMain.paths.endIndex).count - 1
            navigationMain.paths.remove(at: numToPop)
        case .modal:
            guard var navigationModal = self.navigationModal, let found = navigationModal.paths.firstIndex(where: { $0 == to }) else { return }
            let numToPop = (found..<navigationModal.paths.endIndex).count - 1
            navigationModal.paths.remove(at: numToPop)
        }
    }

    func presentModal(_ root: T) {
        navigationModal = (root: root, paths: [])
        navigationState = .modal
    }
    
    func dismissModal() {
        navigationState = .main
    }
    
    func presentSheet(_ path: T) {
        sheet = path
        isSheetPresented = true
    }
    
    func removeSheet() {
        isSheetPresented = false
        sheet = nil
    }
}

struct RouterView<T: Hashable, Content: View>: View {
    @StateObject var coordinator: Coordinator<T>
    @ViewBuilder var content: (T) -> Content

    var body: some View {
        ZStack {
            let root = coordinator.navigationMain.root
            let paths = coordinator.navigationMain.paths
            NavigationStack(path: .constant(paths)) {
                content(root)
                    .navigationDestination(for: T.self) { path in
                        content(path)
                            .navigationBarBackButtonHidden(true)
                            .toolbarItem(placement: .navigationBarLeading) {
                                if paths.count > 0 {
                                    AppButtonBar(imageName: "chevron.left.circle.fill", action: {
                                        coordinator.pop()
                                    })
                                }
                            }
                    }
            }
            .zIndex(0)
            
            if coordinator.isModalPresented {
                if let navigationModal = coordinator.navigationModal {
                    NavigationStack(path: .constant(navigationModal.paths)) {
                        content(navigationModal.root)
                            .navigationDestination(for: T.self) { path in
                                content(path)
                                    .navigationBarBackButtonHidden(navigationModal.paths.count > 0)
                                    .toolbarItem(placement: .navigationBarLeading) {
                                        AppButtonBar(imageName: "chevron.left.circle.fill", action: {
                                            coordinator.pop()
                                        })
                                    }
                            }
                    }
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .animation(.easeIn(duration: 0.4), value: coordinator.isModalPresented)
        .sheet(isPresented: $coordinator.isSheetPresented) {
            if let sheetContent = coordinator.sheet {
                NavigationView {
                    content(sheetContent)
                        .toolbarItem(placement: .navigationBarTrailing) {
                            AppButtonBar(imageName: "xmark.circle.fill", action: {
                                coordinator.removeSheet()
                            })
                        }
                }
            }
        }
    }
}
