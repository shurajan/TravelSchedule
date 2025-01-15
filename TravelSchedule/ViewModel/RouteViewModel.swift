//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

final class RouteViewModel: ObservableObject {
    private var trip: Trip
    private let routes: [Route]
    
    var filteredRoutes: [Route] {
        guard let fromStation = trip.fromStation,
              let toStation = trip.toStation else {
            return []
        }
        return findRoute(from: fromStation.code, to: toStation.code)
    }
    
    init(trip: Trip, routes: [Route] = Route.mockRoutes) {
        self.trip = trip
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
