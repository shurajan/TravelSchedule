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
        return routes.filter { route in
            matches(fromStation: route.stations.first, toStation: route.stations.last) &&
            matchesTimeOfDay(route.departureTime) &&
            matchesIsDirect(route.isDirect)
        }
    }
    
    init(trip: Trip, routes: [Route] = Route.mockRoutes) {
        self.trip = trip
        self.routes = routes
    }
    
    private func matches(fromStation: String?, toStation: String?) -> Bool {
        guard let fromStationCode = trip.from?.name,
              let toStationCode = trip.to?.name else {
            return true
        }
        return fromStation == fromStationCode && toStation == toStationCode
    }
    
    private func matchesTimeOfDay(_ departureTime: Date) -> Bool {
        if trip.TimeOfDay.isEmpty {
            return true
        }
        return trip.TimeOfDay.contains(departureTime.timeOfDay)
    }
    
    private func matchesIsDirect(_ isDirect: Bool) -> Bool {
        guard let filter = self.trip.isDirect else {return true}
        
        if filter {
            return isDirect
        }
            
        return true
    }
}
