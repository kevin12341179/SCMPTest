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
                ForEach(viewModel.users, id: \.id) { user in
                    userCell(user: user, showLoadMoore: viewModel.users.last == user)
                }
            }
        }
        .onAppear {
            viewModel.getUser()
        }
        .alert(isPresented: $viewModel.apiFail) {
            Alert(title: Text("API Fail"))
        }
    }
    
    func userCell(user: User, showLoadMoore: Bool = false) -> some View {
        VStack(alignment: .leading ) {
            if let uiImage = ImageHelper.exitsImage(urlString: user.avatar) {
                Image(uiImage: uiImage)
            } else {
                if let url = URL(string: user.avatar) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Color.gray
                        case .success(let image):
                            image
                                .onAppear {
                                    ImageHelper.saveImage(urlString: user.avatar, image: image)
                                }
                        case .failure(_):
                            Image(systemName: "exclamationmark.icloud")
                        default:
                            Image(systemName: "exclamationmark.icloud")
                        }
                    }
                }
            }
            Text("id: \(user.id)")
            Text("email: \(user.email)")
            Text("firstName: \(user.firstName)")
            Text("lastName: \(user.lastName)")
            Text("avatar: \(user.avatar)")
            
            if showLoadMoore, viewModel.needLoadMore {
                HStack {
                    Spacer()
                    Text("Load More...")
                        .foregroundStyle(.blue)
                        .onAppear {
                            viewModel.loadMoreUser()
                        }
                    ProgressView()
                    Spacer()
                }
                .padding(.top, 10)
            }
        }
    }
}

#Preview {
    UsersView(token: "123456")
}
