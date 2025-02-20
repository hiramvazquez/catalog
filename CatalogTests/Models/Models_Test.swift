//
//  Models_Test.swift
//  CatalogTests
//
//  Created by Hiram Vázquez Almeida on 19/02/25.
//

import XCTest
@testable import Catalog

final class Models_Test: XCTestCase {
    func testLocalGame_Init() throws {
        // Given
        let id: Int = 582
        let title: String = "Tarisland"
        let thumbnail: String = "https://www.freetogame.com/g/582/thumbnail.jpg"
        let shortDescription: String = "A cross-platform MMORPG developed by Level Infinite and Published by Tencent."
        let gameUrl: String = "https://www.freetogame.com/open/tarisland"
        let genre: String = "MMORPG"
        let platform: String = "PC (Windows)"
        let publisher: String = "Tencent"
        let developer: String = "Level Infinite"
        let releaseDate: String = "2024-06-22"
        let freetogameProfileUrl: String = "https://www.freetogame.com/tarisland"
        
        //When
        let model = LocalGame(id: id,
                              title: title,
                              thumbnail: thumbnail,
                              short_description: shortDescription,
                              game_url: gameUrl,
                              genre: genre,
                              platform: platform,
                              publisher: publisher,
                              developer: developer,
                              release_date: releaseDate,
                              freetogame_profile_url: freetogameProfileUrl)
        
        // Then
        XCTAssertEqual(model.id, id)
        XCTAssertEqual(model.title, title)
        XCTAssertEqual(model.thumbnail, thumbnail)
        XCTAssertEqual(model.short_description, shortDescription)
        XCTAssertEqual(model.game_url, gameUrl)
        XCTAssertEqual(model.genre, genre)
        XCTAssertEqual(model.platform, platform)
        XCTAssertEqual(model.publisher, publisher)
        XCTAssertEqual(model.developer, developer)
        XCTAssertEqual(model.release_date, releaseDate)
        XCTAssertEqual(model.freetogame_profile_url, freetogameProfileUrl)
    }
    
    @MainActor
    func testLocalGame_ImageURL() throws {
        // Given
        let imageURL: URL? = URL(string: "https://www.freetogame.com/g/582/thumbnail.jpg")
        
        //When
        let localGame = AppPreview.shared.game
        
        // Then
        XCTAssertEqual(localGame.imageURL, imageURL)
    }
    
    @MainActor
    func testLocalGame_GameURL() throws {
        // Given
        let gameURL: URL? = URL(string: "https://www.freetogame.com/open/tarisland")
        
        //When
        let localGame = AppPreview.shared.game
        
        // Then
        XCTAssertEqual(localGame.gameURL, gameURL)
    }
    
    func testGameListRequest_Func() throws {
        // Given
        let endPoint = APIEndpoints.gameList
        
        //When
        let request = AppRequest(request: GameListRequest())
        
        // Then
        XCTAssertNil(request.toParams())
        XCTAssertEqual(request.endPoint(), endPoint)
    }
}
