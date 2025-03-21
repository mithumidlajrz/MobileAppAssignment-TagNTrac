//
//  CustomComponents.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by Muhammad on 15/03/25.
//

import SwiftUI

struct ProductLogoText: View {
    let productLogo: String
    
    var body: some View {
        Text(productLogo)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 40)
    }
}

struct logoText: View {
    let logotext: String

    var body: some View {
        Text(logotext)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .frame(width: 80, height: 40)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)

    }
}

struct NextButtonView: View {
    let buttonText: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text(buttonText)
                    .fontWeight(.bold)
                Image(systemName: "arrow.right")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.tagNtrac)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
        }
    }
}
