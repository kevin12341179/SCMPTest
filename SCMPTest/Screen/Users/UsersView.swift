//
//  UsersView.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject var viewModel: UsersViewModel = UsersViewModel()
    
    var token: String
    
    var body: some View {
        VStack {
            Text("token: \(token)")
            List {
                ForEach(0..<viewModel.users.count, id: \.self) { index in
                    let user = viewModel.users[index]
                    userCell(user: user)
                }
                if viewModel.needLoadmore {
                    Text("Load More...")
                        .onAppear {
                            viewModel.loadMoreUser()
                        }
                }
            }
        }
        .onAppear {
            viewModel.getUser()
        }
    }
    
    func userCell(user: User) -> some View {
        VStack(alignment: .leading ) {
            Text("id: \(user.id)")
            Text("email: \(user.email)")
            Text("firstName: \(user.firstName)")
            Text("lastName: \(user.lastName)")
            Text("avatar: \(user.avatar)")
        }
    }
}

#Preview {
    UsersView(token: "123456")
}
