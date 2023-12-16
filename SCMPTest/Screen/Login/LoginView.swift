//
//  ContentView.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import SwiftUI

enum LoginViewField: Hashable {
    case emailField
    case passwordField
}

struct LoginView: View {
    @EnvironmentObject var appRouter: AppRouter
    @StateObject var viewModel: LoginViewViewModel = LoginViewViewModel()
    @FocusState var focusedField: LoginViewField?
    @State private var isSecured: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            
            if viewModel.loginError {
                Text("Login Fail")
                    .foregroundStyle(.red)
            }
            
            email
            
            password
            
            Spacer()
            
            Button(action: {
                viewModel.login()
                focusedField = nil
                appRouter.isShowLoading = true
            }, label: {
                ZStack {
                    if viewModel.canLogin {
                        Color.blue
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                        Text("Login")
                            .foregroundStyle(.white)
                    } else {
                        Color.gray
                            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                        Text("Login")
                    }
                }
                
            })
            .disabled(!viewModel.canLogin)
        }
        .padding()
        .task(id: viewModel.token, {
            guard !viewModel.token.isEmpty else {
                return
            }
            
            appRouter.isShowLoading = false
            appRouter.routing(to: .users(token: viewModel.token))
            viewModel.cleanToken()
        })
        .onChange(of: viewModel.loginError, perform: { value in
            appRouter.isShowLoading = false
        })
    }
    
    var password: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Password")
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if isSecured {
                        SecureField("",
                                    text: $viewModel.password,
                                    prompt: Text("Password"))
                        .focused($focusedField, equals: LoginViewField.passwordField)
                        .textInputAutocapitalization(.never)
                        .limitText($viewModel.password, to: 10)
                    } else {
                        TextField("",
                                  text: $viewModel.password,
                                  prompt: Text("Password"))
                        .focused($focusedField, equals: LoginViewField.passwordField)
                        .textInputAutocapitalization(.never)
                        .limitText($viewModel.password, to: 10)
                    }
                    
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                    }
                }
                
                
                Divider()
                    .scmpLine(height: 1, isFocused: .constant(focusedField == .passwordField),
                              isError: $viewModel.isPasswordError)
                
                if viewModel.isPasswordError {
                    Text("Password Error")
                        .foregroundStyle(.red)
                }
            }
        }
    }
    
    var email: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Email")
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("",
                          text: $viewModel.email,
                          prompt: Text("Email"))
                .focused($focusedField, equals: LoginViewField.emailField)
                .textInputAutocapitalization(.never)
                
                Divider()
                    .scmpLine(height: 1, isFocused: .constant(focusedField == .emailField),
                              isError: $viewModel.isEmailError)
                
                if viewModel.isEmailError {
                    Text("Email Error")
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
