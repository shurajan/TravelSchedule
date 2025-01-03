//
//  ThreadsService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Threads = Components.Schemas.Threads

protocol ThreadsServiceProtocol {
    func getThreads(uid: String) async throws -> Threads
}

final class ThreadsService: BasicService, ThreadsServiceProtocol {
    
    func getThreads(uid: String) async throws -> Threads {
        
        let response = try await client.getThreads(query: .init(
            apikey: self.apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
