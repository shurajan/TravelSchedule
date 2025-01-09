//
//  CitySelectorViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

final class CitySelectorViewModel: SelectorViewModelProtocol {
    @Published var searchText: String = ""
    
    private let allItems: [City] = [
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
    
    var filteredItems: [String] {
        guard !searchText.isEmpty else {
            return allItems.map { $0.name }
        }
        return allItems
            .filter { $0.name.lowercased().contains(searchText.lowercased()) }
            .map { $0.name }
    }
}
