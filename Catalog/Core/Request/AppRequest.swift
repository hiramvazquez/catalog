//
//  AppRequest.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

protocol RequestParam: Encodable {
    func endPoint() -> APIEndpoints
}

struct AppRequest<T: RequestParam> : Encodable {
    var request: T
    
    func endPoint() -> APIEndpoints {
        request.endPoint()
    }
}
