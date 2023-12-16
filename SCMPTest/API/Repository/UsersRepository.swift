//
//  UsersRepository.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import Combine

protocol UsersRepositoryInterFace {
    func getUsers(page: Int) -> AnyPublisher<UsersModel, Error>
}

class UsersRepository: UsersRepositoryInterFace{
    static let shared = UsersRepository()
    
    func getUsers(page: Int) -> AnyPublisher<UsersModel, Error> {
        return APIManager.shared.request(endpoint: .users(page: page))
            .eraseToAnyPublisher()
    }
}
