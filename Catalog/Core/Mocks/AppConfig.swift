//
//  AppConfig.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 20/02/25.
//

import Foundation

struct AppConfig {
    static var isTestOrPreview: Bool {
        var isXCTest: Bool {
            #if TESTING
               return true
            #else
               return false
            #endif
        }
        var isPreviews: Bool {
            ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        }
        return isXCTest || isPreviews
    }
}

enum TestCodeChecker {
    enum TestApiCode: Int {
        case success = 200
        case error = 400
    }
    
    static let code: TestApiCode = .success
}
