//
//  City.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//

import Foundation

struct City: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let stations: [Station]
}

//MARK: - test data for development
extension City {
    static let mockCities: [City] = [
        City(name: "Москва", stations: [
            Station(name: "Ленинградский вокзал", code: "MOW001"),
            Station(name: "Казанский вокзал", code: "MOW002")
        ]),
        City(name: "Санкт-Петербург", stations: [
            Station(name: "Московский вокзал", code: "SPB001")
        ]),
        City(name: "Сочи", stations: [
            Station(name: "Адлер", code: "SOC001")
        ]),
        City(name: "Краснодар", stations: [
            Station(name: "Краснодар-1", code: "KRD001")
        ])
    ]
}
