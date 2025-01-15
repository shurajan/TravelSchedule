//
//  UIColor+Extension.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 16.01.2025.
//

import UIKit

extension UIColor {
    var hexString: String {
        let components = cgColor.components ?? [0, 0, 0, 0]
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
