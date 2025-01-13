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
    func getSearches(from: String, to: String, transfers: Bool) async throws -> Searches
}

final class SearchesService: BasicService, SearchesServiceProtocol {

    func getSearches(from: String, to: String, transfers: Bool = true) async throws -> Searches {

        let response = try await client.getSearches(query: .init(
            apikey: self.apikey,
            from: from,
            to: to,
            transfers: transfers
        ))
        return try response.ok.body.json
    }
}
