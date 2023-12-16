//
//  UsersViewModel.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import Combine

final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []

    var needLoadmore: Bool {
        return page != totalPage
    }
    var page: Int = 1
    var totalPage: Int = 1
    
    var usersRepository: UsersRepositoryInterFace
    
    init(usersRepository: UsersRepositoryInterFace = UsersRepository.shared) {
        self.usersRepository = usersRepository
    }
    
    private var anyCancellable = Set<AnyCancellable>()
    
    func getUser() {
        self._getUser()
    }
    
    func loadMoreUser() {
        self._getUser(page: page + 1)
    }
    
    private func _getUser(page: Int = 1) {
        self.page = page
        usersRepository
            .getUsers(page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(_):
                    
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                self.totalPage = data.totalPages
                if data.page == 1 {
                    self.users = data.data
                } else {
                    self.users.append(contentsOf: data.data)
                }
            }
            .store(in: &anyCancellable)
    }
}
