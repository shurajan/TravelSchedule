//
//  ColorPalette.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

enum AppColors {
    case black
    case white
    case gray
    case lightGray
    case blue
    case red
    case darkGray
    
    var color: Color {
        switch self {
        case .black:
            return Color(hex: "#1A1B22")
        case .white:
            return Color(hex: "#FFFFFF")
        case .gray:
            return Color(hex: "#AEAFB4")
        case .lightGray:
            return Color(hex: "#EEEEEE")
        case .blue:
            return Color(hex: "#3772E7")
        case .red:
            return Color(hex: "#F56B6C")
        case .darkGray:
            return Color(hex: "#767680", opacity: 0.24)
        }
    }
}

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8 * 17) & 0xFF, (int >> 4 * 17) & 0xFF, (int * 17) & 0xFF)
        case 6:
            (a, r, g, b) = (255, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xFF, (int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: opacity
        )
    }
}
