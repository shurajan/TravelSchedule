//
//  Copyright.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightObject = Components.Schemas.CopyrightObject

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightObject
}

final class CopyrightService: BasicService, CopyrightServiceProtocol {
    
    func getCopyright() async throws -> CopyrightObject {
        
        let response = try await client.getCopyright(query: .init(
            apikey: self.apikey
        ))
        return try response.ok.body.json
    }
}
