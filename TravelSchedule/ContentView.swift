//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.12.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    @StateObject private var theme = Theme()
    @StateObject private var errorService: ErrorService = ErrorService()
    
    var body: some View {
        MainTabView()
            .environmentObject(theme)
            .environmentObject(errorService)
            .onAppear {
                do {
                    //try nearestStations()
                    try searches()
                    //try schedules()
                    //try threads()
                    //try nearestSettlement()
                    //try carriers()
                    //try stationsList()
                    //try copyright()
                    print("Loaded")
                } catch {
                    print(error.localizedDescription)
                    errorService.showError(.serverError(message: error.localizedDescription))
                }
            }
    }
    
    private func nearestStations() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    private func searches() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = SearchesService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let searches = try await service.getSearches(from: "s9600213", to: "s9727331")
            print(searches)
        }
    }
    
    private func schedules() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = SchedulesService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let schedules = try await service.getSchedules(station: "s2006004")
            print(schedules)
        }
    }
    
    private func threads() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadsService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let threads = try await service.getThreads(uid: "092S_1_2")
            print(threads)
        }
    }
    
    private func nearestSettlement() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let settlement = try await service.getNearestSettlement(lat: 55.814495, lng: 49.19993, distance: 50)
            print(settlement)
        }
    }
    
    private func carriers() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CarriersService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let carriers = try await service.getCarriers(code: "680")
            print(carriers)
        }
    }
    
    private func stationsList(timeout: TimeInterval = 120) throws {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeout
        sessionConfiguration.timeoutIntervalForResource = timeout
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let transportConfiguration = URLSessionTransport.Configuration(session: session)
        
        let transport = URLSessionTransport(configuration: transportConfiguration)
        
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: transport
        )
        
        let service = StationsListService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            do {
                let stationsList = try await service.getStationsList()
                print(stationsList.countries?.count ?? "Not loaded")
                
            } catch {
                print("Error fetching stations list: \(error)")
            }
        }
    }
    
    private func copyright() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        Task {
            let copyright = try await service.getCopyright()
            print(copyright)
        }
    }
}

#Preview {
    ContentView()
}
