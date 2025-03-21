//
//  SignInViewModel.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 13/03/25.
//

import Foundation

@MainActor
// ViewModel for handling user authentication logic
class SignInViewModel: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            AppUserDefaults.setIsLoggedIn(isLoggedIn)
        }
    }
    @Published var loggedInUserEmail: String? {
        didSet {
            AppUserDefaults.loggedInEmail(loggedInUserEmail)
        }
    }
    @Published var isLoggingIn: Bool = false
    
    // Initializes login state from UserDefaults
    init() {
        self.isLoggedIn = AppUserDefaults.getIsLoggedIn()
        self.loggedInUserEmail = AppUserDefaults.getLoggedInEmail()
    }
    
    // Handles user login validation
    // - Parameters:
    //   - email: User's email input
    //   - password: User's password input
    //   - completion: Callback with success status and optional error message
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        if let user = mockUsers1.first(where: { $0.email == email.lowercased() && $0.password == password }) {
            self.isLoggingIn = true     // Show ProgressView
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoggedIn = true
                self.loggedInUserEmail = user.email
                completion(true, nil)
                self.isLoggingIn = false
            }
        } else {
            completion(false, "Invalid credentials. Please try again.")
        }
    }
    
    // Handles user workspaceID
    // - Parameters:
    //  - id: User's workspace ID
    func WorkspaceIdLogin(_ id: String, completion: @escaping (Bool, String?) -> Void) {
        if workspaceIdMockUsers.contains(id) {
            completion(true, nil)
        } else {
            completion(false, "Invalid workspace ID. Please try again.")
        }
    }
    
    // Logs out the user and clears login data
    func logout() {
        isLoggedIn = false
        loggedInUserEmail = nil
    }
}
