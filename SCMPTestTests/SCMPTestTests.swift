//
//  SCMPTestTests.swift
//  SCMPTestTests
//
//  Created by Kevin Hsu on 2023/12/16.
//

import XCTest
import Combine
@testable import SCMPTest

final class SCMPTestTests: XCTestCase {
    var loginRepo: LoginRepositoryInterFace!
    var userRepo: UsersRepositoryInterFace!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        self.loginRepo = LoginRepository.shared
        self.userRepo = UsersRepository.shared
        self.cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        self.cancellable = nil
    }
    
    func test_getUser() throws {
        let expect = expectation(description: #function)
        var result = UsersModel.defaultUsers

        userRepo.getUsers(page: 1)
            .sink { completion in
                switch completion {
                case .failure(_):
                    // do error things
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                result = data
                expect.fulfill()
            }
            .store(in: &cancellable)

        waitForExpectations(timeout: 30.0) { error in
            XCTAssertTrue(error == nil)
            XCTAssertEqual(result.page, 1)
            XCTAssertEqual(result.perPage, 6)
            XCTAssertEqual(result.total, 12)
            XCTAssertEqual(result.totalPages, 2)
            XCTAssertEqual(result.data.count, 6)
            XCTAssertEqual(result.data[0].lastName, "Bluth")
            XCTAssertEqual(result.data[1].lastName, "Weaver")
            XCTAssertEqual(result.data[2].lastName, "Wong")
            XCTAssertEqual(result.data[3].lastName, "Holt")
            XCTAssertEqual(result.data[4].lastName, "Morris")
            XCTAssertEqual(result.data[5].lastName, "Ramos")
        }
    }
    
    func test_login() throws {
        let expect = expectation(description: #function)
        var result = LoginModel.defaultLoginModel
        
        loginRepo.login(email: "email", password: "password")
            .sink { completion in
                switch completion {
                case .failure(let _):
                    // do error things
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                result = data
                expect.fulfill()
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 30.0) { error in
            XCTAssertTrue(error == nil)
            XCTAssertEqual(result.token, "abcd12345")
        }
    }
}
