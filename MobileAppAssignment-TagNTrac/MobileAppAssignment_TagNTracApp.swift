//
//  MobileAppAssignment_TagNTracApp.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 12/03/25.
//

import SwiftUI

@main
struct MobileAppAssignment_TagNTracApp: App {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoggedIn {
                NavigationStack {
                    HomeBaseView()
                }
                .environmentObject(viewModel)
            } else {
                NavigationStack {
                    WorkspaceSignInBaseView()
                }
                .environmentObject(viewModel)
            }
        }
    }
}
