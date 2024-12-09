//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.12.2024.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
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
                try stations()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func stations() throws {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: "05d03cb7-d988-4bb4-92cb-513b293fd349"
        )
        
        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
            print(stations)
        }
    }
}

#Preview {
    ContentView()
}
