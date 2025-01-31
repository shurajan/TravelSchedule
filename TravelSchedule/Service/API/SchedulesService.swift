//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedules = Components.Schemas.Schedules

actor SchedulesService: @unchecked Sendable {
    let client: Client
    let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSchedules(station: String) async throws -> Schedules {
        
        let response = try await client.getSchedule(query: .init(
            apikey: self.apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
