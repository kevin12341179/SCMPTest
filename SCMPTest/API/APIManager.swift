//
//  APIManager.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import Combine

enum ErrorType: Error{
    case UrlError
    case ApiError
}

class APIManager {
    static let shared = APIManager()
    var cancellable = Set<AnyCancellable>()
    
    func request<T: Codable>(endpoint: APIEndpoint) -> AnyPublisher<T, Error> {        
        if let _ = NSClassFromString("XCTestCase") {
            return MockManger.shared.requestMockAPI(urlstring: endpoint.url)
        }
        
        var urlString = endpoint.url
        
        if endpoint.httpMethod == .GET {
            var bodyString = ""
            endpoint.body?.keys.forEach({ key in
                bodyString = bodyString.isEmpty ? "?\(key)=\(endpoint.body?[key] ?? "")" : "&&\(key)=\(endpoint.body?[key] ?? "")"
            })
            urlString = urlString + bodyString
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: ErrorType.UrlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        if endpoint.httpMethod == .POST {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let body = endpoint.body {
                let bodyData = try? JSONSerialization.data(
                    withJSONObject: body,
                    options: []
                )
                request.httpBody = bodyData
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
