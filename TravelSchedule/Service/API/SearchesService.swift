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

final class SearchesService: BasicService, @unchecked Sendable {
    private let from: String
    private let to: String
    private let transfers: Bool
    
    init(client: Client, apikey: String, from: String, to: String, transfers: Bool = true) {
        self.from = from
        self.to = to
        self.transfers = transfers
        super.init(client: client, apikey: apikey)
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
