//
//  AppPreview.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class AppPreview {
    @MainActor static let shared = AppPreview()
    
    let game: LocalGame = LocalGame(id: 123,
                          title: "Tarisland",
                          thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
                          short_description: "A cross-platform MMORPG developed by Level Infinite and Published by Tencent.",
                          game_url: "https://www.freetogame.com/open/tarisland",
                          genre: "MMORPG",
                          platform: "PC (Windows)",
                          publisher: "Tencent",
                          developer: "Level Infinite",
                          release_date: "2024-06-22",
                          freetogame_profile_url: "https://www.freetogame.com/tarisland")
}
