//
//  WorkspaceSignInView.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 12/03/25.
//

import SwiftUI

struct WorkspaceSignInView: View {
    @EnvironmentObject var viewModel : SignInViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isPresented = false  // State to control navigation
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Product Logo
                ProductLogoText(productLogo: "Product Logo")
                
                // Logo
                logoText(logotext: "Logo")

                // Email Input Field
                VStack(alignment: .leading, spacing: 5) {
                    // Email Label with Animation
                    Text(email.isEmpty ? "" : "Email")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .animation(.smooth, value: email.isEmpty)
                    
                    // Email Input Field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding(.vertical, 10)
                        .overlay(Divider(), alignment: .bottom)
                }
                .padding(.horizontal, 40)
                
                // Password Input Field
                VStack(alignment: .leading, spacing: 5) {
                    Text(password.isEmpty ? "" : "Password")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .animation(.smooth, value: password.isEmpty)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                            .contentTransition(.symbolEffect(.automatic))
                            .onTapGesture {
                                withAnimation {
                                    isPasswordVisible.toggle()
                                }
                            }
                    }
                    .padding(.vertical, 10)
                    .overlay(Divider(), alignment: .bottom)
                }
                .padding(.horizontal, 40)
                
                // Forgot Password Text
                HStack {
                    if let error = errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.caption2)
                            .minimumScaleFactor(0.8)
                    }
                    
                    Spacer()
                    Text("Forgot Password?")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 40)
                
                // Sign In Button
                NextButtonView(buttonText: "Sign in") {
                    signInButtonTapped()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                // Powered By Section
                VStack {
                    Text("Powered By")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Text("Logo")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(width: 80, height: 40)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // Scanner & Tracker Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Scanner Action
                        print("Scanner button tapped")
                    }) {
                        HStack {
                            Image(systemName: "qrcode.viewfinder")
                            Text("Scanner")
                        }
                        .padding()
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.201755017, blue: 0.4773958921, alpha: 1)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    
                    Button(action: {
                        // Tracker Action
                        print("Tracker button tapped")
                    }) {
                        HStack {
                            Image(systemName: "location.circle")
                            Text("Tracker")
                        }
                        .padding()
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.201755017, blue: 0.4773958921, alpha: 1)))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                }
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
            .overlay {
                if viewModel.isLoggingIn {
                    VStack {
                        ProgressView("Logging in...")
                            .font(.caption)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.1)) // Dim background
                    .ignoresSafeArea()
                }
            }
            .navigationDestination(isPresented: $isPresented) {
                HomeBaseView()
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    //MARK: - Button action
    
    fileprivate func signInButtonTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required."
            return
        }
        
        viewModel.login(email: email, password: password) { isSuccess, errorMsg in
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
