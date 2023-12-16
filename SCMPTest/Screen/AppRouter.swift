//
//  AppRouter.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation

final class AppRouter: ObservableObject {
    @Published var path: [AppPath] = []
    
    @MainActor func routing(to path: AppPath) {
        DispatchQueue.main.async {
            self.path.append(path)
        }
    }
}
