//
//  WorkspaceSignInBaseView.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 12/03/25.
//

import SwiftUI

struct WorkspaceSignInBaseView: View {
    @EnvironmentObject var viewModel : SignInViewModel
    @State private var isPresented = false  // State to control navigation
    @State private var workspaceID: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            // Product Logo
            
            ProductLogoText(productLogo: "Product Logo")
            
            Spacer()
            
            // Sign-in Title
            VStack(alignment: .leading, spacing: 8) {
                Text("Sign in to your workspace")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .kerning(1)
                    .padding(.horizontal)
                    .minimumScaleFactor(0.7)
                
                Text("Enter your workspace identifier")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // Workspace Identifier Input
            VStack(alignment: .leading) {
                TextField("Workspace Identifier", text: $workspaceID)
                    .autocorrectionDisabled()
                    .padding()
                    .overlay(Divider().padding(.horizontal), alignment: .bottom)
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .padding()
            // Next Button

            NextButtonView(buttonText: "Next") {
                IdLoginTapped()
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Spacer()
            
            // Powered By Section
            VStack {
                Text("Powered By")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                logoText(logotext: "Logo")

            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        
        // Nav Destination
        .navigationDestination(isPresented: $isPresented) {
            WorkspaceSignInView()
        }
    }
    
    //MARK: - Button action
    
    fileprivate func IdLoginTapped() {
        guard !workspaceID.isEmpty else {
            errorMessage = "Workspace ID is required"
            return
        }
        
        viewModel.WorkspaceIdLogin(workspaceID) { isSuccess, errorMsg in
            if isSuccess {
                withAnimation {
                    self.errorMessage = nil
                    self.isPresented.toggle()
                }
            } else {
                self.errorMessage = errorMsg
            }
        }
    }
}

