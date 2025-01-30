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

extension Route {
    static let mockRoutes: [Route] = [
        Route(
            departureTime: "2025-01-14T22:30:00+03:00",
            arrivalTime: "2025-01-15T08:15:00+03:00",
            duration: 20 * 3600,
            stops: "С пересадкой в Костроме",
            isDirect: false,
            carrierCode: Carrier.mockCarriers[0].code
        ),
        Route(
            departureTime: "2025-01-15T01:15:00+03:00",
            arrivalTime: "2025-01-15T09:00:00+03:00",
            duration: 9 * 3600,
            stops: "",
            isDirect: true,
            carrierCode: Carrier.mockCarriers[1].code
        ),
        Route(
            departureTime: "2025-01-16T12:30:00+03:00",
            arrivalTime: "2025-01-16T21:00:00+03:00",
            duration: 9 * 3600,
            stops: "",
            isDirect: true,
            carrierCode: Carrier.mockCarriers[2].code
        ),
        Route(
            departureTime: "2025-01-17T22:30:00+03:00",
            arrivalTime: "2025-01-18T08:15:00+03:00",
            duration: 20 * 3600,
            stops: "С пересадкой в Новгороде",
            isDirect: false,
            carrierCode: Carrier.mockCarriers[0].code
        ),
        Route(
            departureTime: "2025-01-17T22:30:00+03:00",
            arrivalTime: "2025-01-18T08:30:00+03:00",
            duration: 12 * 3600,
            stops: "С пересадкой в Твери",
            isDirect: false,
            carrierCode: Carrier.mockCarriers[0].code
        ),
        Route(
            departureTime: "2025-01-14T22:30:00+03:00",
            arrivalTime: "2025-01-16T00:30:00+03:00",
            duration: 26 * 3600,
            stops: "",
            isDirect: true,
            carrierCode: Carrier.mockCarriers[0].code
        ),
        Route(
            departureTime: "2025-01-14T22:30:00+03:00",
            arrivalTime: "2025-01-16T02:30:00+03:00",
            duration: 28 * 3600,
            stops: "С пересадкой в Ростове-На-Дону",
            isDirect: false,
            carrierCode: Carrier.mockCarriers[0].code
        )
    ]
}

