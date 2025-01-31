//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList
typealias Settlements = Components.Schemas.Settlements

actor StationsListService: @unchecked Sendable {
    let client: Client
    let apikey: String
    private let limit = APIConstants.maxJsonSize
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> [Settlements]? {
        let response = try await client.getStationsList(query: .init(apikey: self.apikey))
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: limit)
        
        let list = try JSONDecoder().decode(StationsList.self, from: data)
        guard let countries = list.countries else { return [] }
        
        let settlements = countries
            .compactMap { $0.regions }
            .flatMap { $0 }
            .compactMap { $0.settlements }
            .flatMap { $0 }
            .filter { ($0.title?.isEmpty ?? true) == false }
        return settlements
    }
}
