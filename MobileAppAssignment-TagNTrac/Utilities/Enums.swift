//
//  Enums.swift
//  MobileAppAssignment-TagNTrac
//
//  Created by SurveyHeart - Midlaj on 18/03/25.
//

import SwiftUI

// Enum for Home tab tracking
enum HomeTabs: String, CaseIterable {
    case home = "Home"
    case assetization = "Assetization"
    case sites = "Sites"
    case shipments = "Shipments"
    case more = "More"

    var icon: String {
        switch self {
        case .home: return "house"
        case .assetization: return "shippingbox"
        case .sites: return "building.2"
        case .shipments: return "truck.box"
        case .more: return "ellipsis"
        }
    }
}

enum FeatureCardVariant: String, CaseIterable {
    case assetization = "Assetization"
    case sites = "Sites"
    case shipments = "Shipments"
    case scan = "Scan"
    case assetSearch = "Asset Search"
    case deviceSearch = "Device Search"
    case settings = "Settings"
    case help = "Help"
    
    var icon: String {
        switch self {
        case .assetization: return "shippingbox"
        case .sites: return "building.2"
        case .shipments: return "truck.box"
        case .scan: return "qrcode.viewfinder"
        case .assetSearch: return "magnifyingglass"
        case .deviceSearch: return "sensor.tag.radiowaves.forward"
        case .settings: return "gearshape"
        case .help: return "questionmark.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .assetization: return .blue
        case .sites: return .orange
        case .shipments: return .yellow
        case .scan: return .green
        case .assetSearch: return .purple
        case .deviceSearch: return .teal
        case .settings: return .yellow
        case .help: return .indigo
        }
    }
}
