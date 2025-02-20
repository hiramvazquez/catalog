//
//  URLProtocol.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 20/02/25.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    nonisolated(unsafe) static var mockRequests: Set<MockNetworkExchange> = []
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let foundRequest = Self.mockRequests.first { [unowned self] in
            request.url?.path == $0.urlRequest.url?.path &&
            request.httpMethod == $0.urlRequest.httpMethod &&
            TestCodeChecker.code.rawValue == $0.response.statusCode
        }
        
        guard let mockExchange = foundRequest else {
            client?.urlProtocol(self, didFailWithError: CustomError.general)
            return
        }
        
        if let data = mockExchange.response.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocol(self, didReceive: mockExchange.urlResponse, cacheStoragePolicy: .notAllowed)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

struct MockResponse: Hashable {
    var statusCode: Int
    var data: Data?
}

struct MockNetworkExchange: Hashable {
    static func == (lhs: MockNetworkExchange, rhs: MockNetworkExchange) -> Bool {
        lhs.urlRequest.url == rhs.urlRequest.url &&
        lhs.response.data == rhs.response.data &&
        lhs.response.statusCode == rhs.response.statusCode
    }
    
    var urlRequest: URLRequest
    var response: MockResponse
    var urlResponse: HTTPURLResponse {
        HTTPURLResponse(
            url: urlRequest.url!,
            statusCode: response.statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }
}
