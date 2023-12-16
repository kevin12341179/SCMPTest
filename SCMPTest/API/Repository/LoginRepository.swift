//
//  LoginRepository.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import Combine

protocol LoginRepositoryInterFace {
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error>
}

class LoginRepository: LoginRepositoryInterFace{
    static let shared = LoginRepository()
    
    func login(email: String, password: String) -> AnyPublisher<LoginModel, Error> {
        return APIManager.shared.request(endpoint: .login(email: email, password: password))
            .map({ $0 })
            .eraseToAnyPublisher()
    }
}
