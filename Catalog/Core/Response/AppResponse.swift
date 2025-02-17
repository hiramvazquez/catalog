//
//  AppResponse.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation

struct AppResponse<T> : Decodable where T : Decodable {
    var response: BaseResponse<T>
}

struct BaseResponse<T> : Decodable where T : Decodable {
    var data: T
}
