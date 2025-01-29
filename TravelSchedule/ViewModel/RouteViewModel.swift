//
//  RoutesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

@MainActor
final class RouteViewModel: ObservableObject {
    @Published var routes: [Route]
    private let trip: Trip
    private let networkClient: NetworkClientService
    private let errorService: ErrorService
    
    var filteredRoutes: [Route] {
        return routes.filter { route in
            let departureTime = Date.ISODateFormatter.date(from: route.departureTime) ?? Date()
            
            return matchesTimeOfDay(departureTime) &&
            matchesIsDirect(route.isDirect)
        }
    }
    
    init(trip: Trip, networkClient: NetworkClientService, errorService: ErrorService) {
        self.trip = trip
        self.networkClient = networkClient
        self.errorService = errorService
        routes = []
        //routes = await RouteViewModel.loadRoutesList(trip: trip, networkClient: networkClient, errorService: errorService)
    }

    func loadRoutesList() async {
        routes = []
        guard let client = networkClient.client else {
            errorService.showError(AppError.networkError(message: "Cannot create client"))
            return
        }
        
        guard let fromCode = trip.fromStation?.code,
              let toCode = trip.toStation?.code
        else {
            return
        }
        
        let apiService = SearchesService(client: client, apikey: APIConstants.apiKey, from: fromCode, to: toCode)
        let transformer = SegmentTransformer()
        let downloader = DataDownloader(apiService: apiService.getSegments, transformer: transformer)
        
        do {
            try await downloader.fetchData()
            routes = await downloader.getItems()
        } catch {
            errorService.showError(AppError.networkError(message: "Cannot load data"))
            return
        }
    }
    
    private func matchesTimeOfDay(_ departureTime: Date) -> Bool {
        if trip.TimeOfDay.isEmpty {
            return true
        }
        return trip.TimeOfDay.contains(departureTime.timeOfDay)
    }
    
    private func matchesIsDirect(_ isDirect: Bool) -> Bool {
        guard let filter = trip.isDirect else {return true}
        
        if filter {
            return isDirect
        }
            
        return true
    }
}
