//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Schedules = Components.Schemas.Schedules

protocol SchedulesServiceProtocol {
    func getSchedules(station: String) async throws -> Schedules
}

final class SchedulesService: BasicService, SchedulesServiceProtocol {
    
    func getSchedules(station: String) async throws -> Schedules {
        
        let response = try await client.getSchedule(query: .init(
            apikey: self.apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
