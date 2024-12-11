//
//  SearchesService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 11.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Searches = Components.Schemas.Searches

protocol SearchesServiceProtocol {
    func getSearches(from: String, to: String) async throws -> Searches
}

final class SearchesService: SearchesServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSearches(from: String, to: String) async throws -> Searches {

        let response = try await client.getSearches(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        return try response.ok.body.json
    }
}
