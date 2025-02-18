//
//  GameListRequest.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

final class GameListRequest: RequestParam {
    func toParams<T>() -> T? where T : Encodable {
        nil
    }
    
    func endPoint() -> APIEndpoints {
        APIEndpoints.gameList
    }
}
