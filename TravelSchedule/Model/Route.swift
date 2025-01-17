//
//  Route.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

struct Route: Hashable, Identifiable {
    let id = UUID()
    let stations: [String]
    let departureTime: Date
    let arrivalTime: Date
    let duration: Int
    var isDirect: Bool {
        stations.count == 2
    }
    let carrierID: UUID
    
    init(stations: [String], departure: String, arrival: String, duration: Int, carrierID: UUID) {
        //TODO: - further changes required 
        self.stations = stations.count >= 2 ? stations : ["Неизвестно", "Неизвестно"]
        
        self.departureTime = Date.ISODateFormatter.date(from: departure) ?? Date()
        self.arrivalTime = Date.ISODateFormatter.date(from: arrival) ?? Date()
        self.duration = duration
        self.carrierID = carrierID
    }
    
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
            stations: ["Москва", "Костроме", "Санкт-Петербург"],
            departure: "2025-01-14T22:30:00+03:00",
            arrival: "2025-01-15T08:15:00+03:00",
            duration: 20 * 3600,
            carrierID: Carrier.mockCarriers[0].id
        ),
        Route(
            stations: ["Москва", "Санкт-Петербург"],
            departure: "2025-01-15T01:15:00+03:00",
            arrival: "2025-01-15T09:00:00+03:00",
            duration: 9 * 3600,
            carrierID: Carrier.mockCarriers[1].id
        ),
        Route(
            stations: ["Москва", "Санкт-Петербург"],
            departure: "2025-01-16T12:30:00+03:00",
            arrival: "2025-01-16T21:00:00+03:00",
            duration: 9 * 3600,
            carrierID: Carrier.mockCarriers[2].id
        ),
        Route(
            stations: ["Москва", "Новгороде", "Санкт-Петербург"],
            departure: "2025-01-17T22:30:00+03:00",
            arrival: "2025-01-18T08:15:00+03:00",
            duration: 20 * 3600, 
            carrierID: Carrier.mockCarriers[0].id
        ),
        Route(
            stations: ["Москва", "Твери", "Санкт-Петербург"],
            departure: "2025-01-17T22:30:00+03:00",
            arrival: "2025-01-18T08:30:00+03:00",
            duration: 12 * 3600,
            carrierID: Carrier.mockCarriers[0].id
        ),
        Route(
            stations: ["Москва", "Сочи"],
            departure: "2025-01-14T22:30:00+03:00",
            arrival: "2025-01-16T00:30:00+03:00",
            duration: 26 * 3600,
            carrierID: Carrier.mockCarriers[0].id
        ),
        Route(
            stations: ["Москва","Ростове-На-Дону", "Сочи"],
            departure: "2025-01-14T22:30:00+03:00",
            arrival: "2025-01-16T02:30:00+03:00",
            duration: 28 * 3600,
            carrierID: Carrier.mockCarriers[0].id
        )
    ]
}

