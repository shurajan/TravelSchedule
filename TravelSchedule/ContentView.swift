//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.12.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    let apiKey = "05d03cb7-d988-4bb4-92cb-513b293fd349"
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            do {
                //try nearestStations()
                try searches()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func nearestStations() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
    
    func searches() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = SearchesService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            let searches = try await service.getSearches(from: "s2000009", to: "s9600213")
            print(searches)
        }
    }
}

#Preview {
    ContentView()
}
