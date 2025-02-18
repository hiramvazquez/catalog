//
//  NetworkingManager.swift
//  Catalog
//
//  Created by Hiram Vázquez Almeida on 17/02/25.
//

import Combine
import Foundation

protocol NetworkingManagerService {
    func execute<E: RequestParam, T: Decodable>(parameters: AppRequest<E>) -> AnyPublisher<T, Error>
}

final class NetworkingManager: NSObject, URLSessionDelegate, NetworkingManagerService {
    private var session: URLSession
    
    override init() {
        session = URLSession(configuration: .default)
    }
    
    func execute<E, T>(parameters: AppRequest<E>) -> AnyPublisher<T, any Error> where E : RequestParam, T : Decodable {
        do {
            let endPoint = parameters.endPoint()
            
            guard let route = endPoint.resource.route else {
                return Fail(error: CustomError.general).eraseToAnyPublisher()
            }
            
            var request = URLRequest(url: route)
            request.httpMethod = endPoint.resource.method.rawValue
            
            endPoint.resource.header.defaults.forEach { (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            if let params = parameters.toParams() {
                request.httpBody = try JSONEncoder().encode(params)
            }
            
            return session.dataTaskPublisher(for: request)
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse else {
                        throw CustomError.invalidResponse
                    }
                    
                    print("----------\nCode:\n\(response.statusCode)\n-------------")
                    self.logs(output: $0, request: request)
                    
                    switch response.statusCode {
                    case (200..<300):
                        return $0.data
                    default:
                        do {
                            let decoded = try JSONDecoder().decode(CustomError.ApiError.self, from: $0.data)
                            throw CustomError.apiError(decoded)
                        } catch {
                            throw error
                        }
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError({ error in
                    if let error = error as? CustomError {
                        return error
                    } else {
                        return CustomError.invalidResponse
                    }
                })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: CustomError.general).eraseToAnyPublisher()
        }
    }
    
    private func logs(output: URLSession.DataTaskPublisher.Output, request: URLRequest) {
        let responseString = NSString(data: output.data, encoding: String.Encoding.utf8.rawValue)
        
        if let url = request.url?.absoluteString {
            print("----------\nURL:\n\(url)\n-------------")
        }
        
        if let headers = request.allHTTPHeaderFields {
            print("-------------\nHeaders:\n\(headers)\n-------------")
        }
        
        if let httpBody = request.httpBody,
           let request = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
           {
            print("-------------\nRequest:\n\(request)\n------------")
        }
        print("-------------\nResponse:\n\(String(describing: responseString))\n------------")
    }
}
