//
//  HomeBaseView.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 12/03/25.
//

import SwiftUI

struct HomeBaseView: View {
    @EnvironmentObject var viewModel: SignInViewModel
    @State private var selectedTab: HomeTabs = .home
    @State private var showLogoutAlert = false
    @State private var isLoggingOut = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(HomeTabs.allCases, id: \.self) { tab in
                tabContentViews(for: tab)
                    .tabItem {
                        Label(tab.rawValue, systemImage: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .accentColor(Color.tagNtrac) // Highlighted tab color
        .toolbar {
            ToolbarItem(placement: .navigation) { // Set the title styling
                Text(selectedTab.rawValue)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white) // Set title color
            }
            
            if selectedTab == .more { // Logout button will only show when selected tab is more tab
                ToolbarItem(placement: .topBarTrailing) {
                    logoutButton
                }
            }
        }
        .navigationBarBackButtonHidden()
        .overlay {
            if isLoggingOut {
                VStack {
                    ProgressView("Logging out...")
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
    }
    
    @ViewBuilder
    var logoutButton: some View {
        Button {
            showLogoutAlert = true
        } label: {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .foregroundColor(.white)
        }
        .alert("Confirm Logout", isPresented: $showLogoutAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Logout", role: .destructive) { performLogout() }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
    
    // Tab Views
    @ViewBuilder
    func tabContentViews(for type: HomeTabs) -> some View {
        switch type {
        case .home:
            HomeView()
        default:
            Text(type.rawValue)
        }
    }
    
    // MARK: - Functions
    func performLogout() {
        isLoggingOut = true // Show ProgressView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // 1.5s delay for smooth transition
            viewModel.logout()
            viewModel.isLoggedIn = false
            isLoggingOut = false // Hide ProgressView
        }
    }
}

struct HomeView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 2) // 2-column grid
    
    var body: some View {
        VStack {
            // Grid Layout
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(FeatureCardVariant.allCases, id: \.self) { variant in
                        FeatureCard(title: variant.rawValue, icon: variant.icon, color: variant.color)
                    }
                }
                .padding()
            }
        }
        .toolbarBackground(Color.tagNtrac, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

//MARK: - Reusable Card Component

struct FeatureCard: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Text("Lorem Ipsum is simply dummy text")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .background(color.opacity(0.1))
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 0.5)
        }
    }
}
