//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlement = Components.Schemas.Settlement

actor NearestSettlementService: @unchecked Sendable {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: self.apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
