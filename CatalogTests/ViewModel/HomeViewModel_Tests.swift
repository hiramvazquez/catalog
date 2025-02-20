//
//  HomeViewModel_Tests.swift
//  CatalogTests
//
//  Created by Hiram Vázquez Almeida on 20/02/25.
//

import XCTest
import Combine
@testable import Catalog

final class HomeViewModel_Tests: XCTestCase {
    let coordinator = Coordinator<AppRoutePath>(initialRoot: .home)
    var viewModel: HomeViewModel?
    var cancellable = Set<AnyCancellable>()
    
    @MainActor
    override func setUpWithError() throws {
        viewModel = HomeViewModel(coordinator: coordinator)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        cancellable.removeAll()
    }
    
    @MainActor
    func test_HomeViewModel_Init() throws {
        guard let viewModel else { return XCTFail() }
        // Given
        let expectation = XCTestExpectation(description: "Return Game List From Mocks")
        
        // When
        viewModel.$gameList
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellable)
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.gameList.count, 2)
        XCTAssertEqual(viewModel.filteredGames.count, 2)
    }
}
