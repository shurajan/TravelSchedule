//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers

actor CarriersService: @unchecked Sendable {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarriers(code: String) async throws -> Carriers {
        
        let response = try await client.getCarrier(query: .init(
            apikey: self.apikey,
            code: code
        ))
        return try response.ok.body.json
    }
}
