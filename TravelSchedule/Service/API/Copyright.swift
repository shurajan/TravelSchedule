//
//  Copyright.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightObject = Components.Schemas.CopyrightObject

actor CopyrightService: @unchecked Sendable {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCopyright() async throws -> CopyrightObject {
        
        let response = try await client.getCopyright(query: .init(
            apikey: self.apikey
        ))
        return try response.ok.body.json
    }
}
