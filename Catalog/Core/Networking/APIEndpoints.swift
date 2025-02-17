//
//  APIEndpoints.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

struct API {
    static var baseUrl: String {
        return "https://www.freetogame.com"
    }
    
    enum HTTPMethod: String {
        case POST
        case GET
        case PUT
    }
    
    enum Headers {
        case base
        
        var defaults: [String: String] {
            switch self {
            case .base:
                return [
                    "Content-Type": "application/json"
                ]
            }
        }
    }
}

enum APIEndpoints {
    case gameList
    
    public var resource: (method: API.HTTPMethod, header: API.Headers, route: URL?) {
        switch self {
        case .gameList:
            return (.GET, .base, URL(string: "\(API.baseUrl)/api/games"))
        }
    }
}
