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
                ZStack {
                    LoginView()
                        .navigationDestination(for: AppPath.self) { path in
                            Color.red
                        }
                    
                    VStack {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color.secondary.colorInvert())
                    .ignoresSafeArea()
                    .opacity(appRouter.isShowLoading ? 1 : 0)
                    
                }
            }
            .environmentObject(appRouter)
        }
    }
}
