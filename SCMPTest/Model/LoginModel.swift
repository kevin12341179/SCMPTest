//
//  LoginModel.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation

struct LoginModel: Codable {
    var token: String
    
    static var defaultLoginModel: LoginModel {
        return LoginModel(token: "default")
    }
}
