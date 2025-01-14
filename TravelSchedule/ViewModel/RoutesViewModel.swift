//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

final class RoutesViewModel: ObservableObject {
    private let routeFinder: RouteFinderProtocol
    private let fromStation: Station
    private let toStation: Station
    @Published var timeOfDay: [Date.TimeOfDay] = []
    @Published var isDirect: Bool = false
    
    var filteredRoutes: [Route] {
        let allOptions = self.routeFinder.findRoute(from: fromStation.code, to: toStation.code)
        return allOptions
    }
    
    init(routeFinder: RouteFinderProtocol, fromStation: Station, toStation: Station) {
        self.fromStation = fromStation
        self.toStation = toStation
        self.routeFinder = routeFinder
    }
}
