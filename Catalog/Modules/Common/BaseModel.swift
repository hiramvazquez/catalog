//
//  BaseModel.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Foundation
import SwiftUI

class BaseModel: ObservableObject {
    internal func toAppRequest<T>(request: T) -> AppRequest<T> where T : RequestParam {
        return AppRequest(request: request)
    }
}
