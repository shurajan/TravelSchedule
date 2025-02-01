//
//  ThreadsService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Threads = Components.Schemas.Threads

actor ThreadsService: @unchecked Sendable {
    let client: Client
    let apikey: String
    private let limit = APIConstants.maxJsonSize
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThreads(uid: String) async throws -> Threads {
        
        let response = try await client.getThreads(query: .init(
            apikey: self.apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
