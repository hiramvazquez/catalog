//
//  Game.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

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
    
    var imageURL: URL? {
        URL(string: thumbnail)
    }
}

//{"id":582,"title":"Tarisland","thumbnail":"https:\/\/www.freetogame.com\/g\/582\/thumbnail.jpg","short_description":"A cross-platform MMORPG developed by Level Infinite and Published by Tencent.","game_url":"https:\/\/www.freetogame.com\/open\/tarisland","genre":"MMORPG","platform":"PC (Windows)","publisher":"Tencent","developer":"Level Infinite","release_date":"2024-06-22","freetogame_profile_url":"https:\/\/www.freetogame.com\/tarisland"}
