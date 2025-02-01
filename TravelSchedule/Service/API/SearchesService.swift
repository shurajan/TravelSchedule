//
//  SearchesService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 11.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias Searches = Components.Schemas.Searches
typealias Segment = Components.Schemas.Segment

actor SearchesService: @unchecked Sendable {
    let client: Client
    let apikey: String
    private let from: String
    private let to: String
    private let transfers: Bool
    

    init(client: Client, apikey: String, from: String, to: String, transfers: Bool = true) {
        self.client = client
        self.apikey = apikey
        self.from = from
        self.to = to
        self.transfers = transfers

    }
    

    func getSegments() async throws -> [Segment]? {
        let date = await String(Date().timeStampString.prefix(10))
        let response = try await client.getSearches(query: .init(
            apikey: self.apikey,
            from: from,
            to: to,
            date: date,
            transfers: transfers
        ))
        
        return try response.ok.body.json.segments
        
    }
}
