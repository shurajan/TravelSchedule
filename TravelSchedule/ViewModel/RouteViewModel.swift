//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

final class RouteViewModel: ObservableObject {
    private var tripViewModel: TripViewModel
    private let routes: [Route]
    
    var filteredRoutes: [Route] {
        guard let fromStation = tripViewModel.fromStation,
              let toStation = tripViewModel.toStation else {
            return []
        }
        return findRoute(from: fromStation.code, to: toStation.code)
    }
    
    init(tripViewModel: TripViewModel, routes: [Route] = Route.mockRoutes) {
        self.tripViewModel = tripViewModel
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
