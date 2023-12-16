//
//  UsersModel.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation

struct UsersModel: Codable {
    var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    var data: [User]
    var support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
    
    static var defaultUsers: UsersModel {
        return UsersModel(page: 10,
                          perPage: 10,
                          total: 20,
                          totalPages: 20,
                          data: [
                            User(id: 1, email: "email1", firstName: "Hsu", lastName: "kevin1", avatar: ""),
                            User(id: 2, email: "email2", firstName: "Hsu", lastName: "kevin2", avatar: ""),
                            User(id: 3, email: "email3", firstName: "Hsu", lastName: "kevin3", avatar: "")
                          ],
                          support: Support(url: "url", text: "text"))
    }
}

struct User: Codable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    var url: String
    var text: String
}
