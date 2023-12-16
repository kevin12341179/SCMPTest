//
//  AppPath.swift
//  SCMPTest
//
//  Created by Kevin Hsu on 2023/12/16.
//

import Foundation

enum AppPath {
    case users(token: String)
}

extension AppPath: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}

extension AppPath {
    static func == (lhs: AppPath, rhs: AppPath) -> Bool {
        switch (lhs, rhs) {
            // MARK: Exercise Paths
        case (.users(let lhs), .users(let rhs)): return lhs == rhs
        }
    }
}

