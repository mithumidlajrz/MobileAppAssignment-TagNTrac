//
//  SignInModel.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 13/03/25.
//

import Foundation

// Mock user model
struct MockUsers {
    let email: String
    let password: String
}

// Multiple mock users data
let mockUsers1: [MockUsers] = [.init(email: "user1@example.com", password: "password123"),
                               .init(email: "user2@example.com", password: "password456"),
                               .init(email: "user3@example.com", password: "password789")]

// Multiple IDs
let workspaceIdMockUsers = ["W123", "W456", "W789"]


// App UserDefaults for storing light weight datas like keys, emails, passwords etc..
struct AppUserDefaults {
    enum Keys: String {
        case isLoggedIn
        case loggedInEmail
    }
    
    static func setIsLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: Keys.isLoggedIn.rawValue)
    }
    
    static func loggedInEmail(_ loggedInUserEmail: String?) {
        return UserDefaults.standard.set(loggedInUserEmail, forKey: Keys.loggedInEmail.rawValue)
    }
    
    static func getIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn.rawValue)
    }
    
    static func getLoggedInEmail() -> String? {
        return UserDefaults.standard.string(forKey: Keys.loggedInEmail.rawValue)
    }
}
