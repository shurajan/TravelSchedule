//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsList
}

final class StationsListService: BasicService, StationsListServiceProtocol {
    private let limit = 1024 * 1024 * 50 //50MiB
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(query: .init(
            apikey: self.apikey
        ))
        let body = try response.ok.body.html
        let data = try await Data(collecting: body, upTo: limit)
        let list = try JSONDecoder().decode(StationsList.self, from: data)
        return list
    }
}
