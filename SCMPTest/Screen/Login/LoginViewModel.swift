//
//  LoginViewModel.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation
import Combine

final class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailError: Bool = false
    
    @Published var password: String = ""
    @Published var isPasswordError: Bool = false
    
    var canLogin: Bool {
        return !email.isEmpty && !isEmailError && !password.isEmpty && !isPasswordError
    }
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init() {
        bindingEmail()
        bindingPassword()
    }
    
    func bindingPassword() {
        $password
            .receive(on: RunLoop.main)
            .sink { _ in
                guard !self.password.isEmpty else {
                    self.isPasswordError = false
                    return
                }
                
                let regex = #"^[a-zA-Z0-9]+$"#
                guard self.password.range(of: regex, options: .regularExpression) != nil else {
                    self.isPasswordError = true
                    return
                }
                
                guard self.password.count >= 6 else {
                    self.isPasswordError = true
                    return
                }
                
                self.isPasswordError = false
            }
            .store(in: &anyCancellable)
    }
    
    func bindingEmail() {
        $email
            .receive(on: RunLoop.main)
            .sink { _ in
                guard !self.email.isEmpty else {
                    self.isEmailError = false
                    return
                }
                
                let regex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
                guard self.email.range(of: regex, options: .regularExpression) != nil else {
                    self.isEmailError = true
                    return
                }
                
                self.isEmailError = false
            }
            .store(in: &anyCancellable)
    }
}
