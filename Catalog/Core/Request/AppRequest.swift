//
//  AppRequest.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

protocol RequestParam: Encodable {
    func toParams<T>() -> T? where T: Encodable
    func endPoint() -> APIEndpoints
}

struct AppRequest<T: RequestParam> {
    var request: T
    
    func endPoint() -> APIEndpoints {
        request.endPoint()
    }
    
    func toParams() -> T? where T: Encodable {
        request.toParams()
    }
}
