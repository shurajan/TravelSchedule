//
//  ColorPalette.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

enum ColorPalette {
    case black(day: Bool)
    case white(day: Bool)
    case gray
    case lightGray
    case blue
    case red
    
    var color: Color {
        switch self {
        case .black(let day):
            return day ? Color(hex: "#1A1B22") : Color(hex: "#FFFFFF")
        case .white(let day):
            return day ? Color(hex: "#FFFFFF") : Color(hex: "#1A1B22")
        case .gray:
            return Color(hex: "#AEAFB4")
        case .lightGray:
            return Color(hex: "#EEEEEE")
        case .blue:
            return Color(hex: "#3772E7")
        case .red:
            return Color(hex: "#F56B6C")
        }
    }
}

extension Color {
    init(hex: String) {
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
            opacity: Double(a) / 255
        )
    }
}
