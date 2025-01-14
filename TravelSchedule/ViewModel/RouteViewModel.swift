//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

final class RouteViewModel: ObservableObject {
    private let routes: [Route]
    private let fromStation: Station
    private let toStation: Station
    @Published var timeOfDay: [Date.TimeOfDay] = []
    @Published var isDirect: Bool = false
    
    var filteredRoutes: [Route] {
        let allOptions = findRoute(from: fromStation.code, to: toStation.code)
        return allOptions
    }
    
    init(routes: [Route] = Route.mockRoutes, fromStation: Station, toStation: Station) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.routes = routes
    }
    
    private func findRoute(from codeFrom: String, to codeTo: String)->[Route] {
        //TODO: - get rid off mock logic for finder
        if codeFrom == "MOW001" && codeTo == "SPB001" {
            return Array(routes[0...4])
        }
        
        if codeFrom == "MOW002" && codeTo == "SOC001" {
            return Array(routes[5...6])
        }
        
        return []
    }
}
