//
//  Carier.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable, Sendable {
    let id = UUID()
    let code: Int
    let name: String
    let logo: String
    let email: String
    let phone: String
    let transportType: String
    
    init(code: Int, name: String, logo: String, email: String, phone: String, transportType: String) {
        self.code = code
        self.name = name
        self.logo = logo
        self.email = email
        self.phone = phone
        self.transportType = transportType
    }
    
    func transportIcon() -> String {
        switch transportType {
        case "plane":
            return "airplane"
        case "train":
            return "train.side.front.car"
        case "suburban":
            return "tram.fill"
        case "bus":
            return "bus.fill"
        case "water":
            return "ferry.fill"
        case "helicopter":
            return "helicopter"
        default:
            return "questionmark.circle"
        }
    }
}
