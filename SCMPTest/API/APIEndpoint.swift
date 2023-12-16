//
//  APIEndpoint.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var url: String { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: Any? { get }
}

enum APIEndpoint {
    case login(email: String, password: String)
    
    case users
}

extension APIEndpoint: Endpoint {
    var url: String {
        return baseURLString + path
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .POST
        case .users:
            return .GET
        }
    }
    
    var baseURLString: String {
        return "https://reqres.in/api"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login?delay=5"
        case .users:
            return "/users?page=1"
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
    
    var body: Any? {
        switch self {
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .users:
            return [:]
        }
    }
}
