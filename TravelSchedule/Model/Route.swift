//
//  Route.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

struct Route: Hashable, Identifiable, Sendable {
    let id = UUID()
    let departureTime: String
    let arrivalTime: String
    let duration: Int
    let stops: String
    var isDirect: Bool
    let carrierCode: Int
    
    func durationText(from seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours) часов \(minutes) минут"
        } else if hours > 0 {
            return "\(hours) часов"
        } else {
            return "\(minutes) минут"
        }
    }
}


