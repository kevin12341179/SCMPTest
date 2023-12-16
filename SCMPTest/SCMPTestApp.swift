//
//  SCMPTestApp.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import SwiftUI

@main
struct SCMPTestApp: App {
    @StateObject var appRouter: AppRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.path) {
                LoginView()
                    .navigationDestination(for: AppPath.self) { path in
                        Color.red
                    }
            }
            .environmentObject(appRouter)
        }
    }
}
