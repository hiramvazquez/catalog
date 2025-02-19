//
//  Game.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftData

@Model
class LocalGame: Hash {
    var id: Int
    var title: String
    var thumbnail: String
    var short_description: String
    var game_url: String
    var genre: String
    var platform: String
    var publisher: String
    var developer: String
    var release_date: String
    var freetogame_profile_url: String
    
    init(id: Int,
         title: String,
         thumbnail: String,
         short_description: String,
         game_url: String,
         genre: String,
         platform: String,
         publisher: String,
         developer: String,
         release_date: String,
         freetogame_profile_url: String) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.short_description = short_description
        self.game_url = game_url
        self.genre = genre
        self.platform = platform
        self.publisher = publisher
        self.developer = developer
        self.release_date = release_date
        self.freetogame_profile_url = freetogame_profile_url
    }
    
    var imageURL: URL? {
        URL(string: thumbnail)
    }
    
    var gameURL: URL? {
        URL(string: game_url)
    }
}

struct Game: Decodable, Hashable {
    var id: Int
    var title: String
    var thumbnail: String
    var short_description: String
    var game_url: String
    var genre: String
    var platform: String
    var publisher: String
    var developer: String
    var release_date: String
    var freetogame_profile_url: String
    
    func toLocalGame() -> LocalGame {
        LocalGame(id: id,
                  title: title,
                  thumbnail: thumbnail,
                  short_description: short_description,
                  game_url: game_url,
                  genre: genre,
                  platform: platform,
                  publisher: publisher,
                  developer: developer,
                  release_date: release_date,
                  freetogame_profile_url: freetogame_profile_url)
    }
}

//{"id":582,"title":"Tarisland","thumbnail":"https:\/\/www.freetogame.com\/g\/582\/thumbnail.jpg","short_description":"A cross-platform MMORPG developed by Level Infinite and Published by Tencent.","game_url":"https:\/\/www.freetogame.com\/open\/tarisland","genre":"MMORPG","platform":"PC (Windows)","publisher":"Tencent","developer":"Level Infinite","release_date":"2024-06-22","freetogame_profile_url":"https:\/\/www.freetogame.com\/tarisland"}
