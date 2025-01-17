//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.12.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers

protocol CarrierServiceProtocol {
    func getCarriers(code: String) async throws -> Carriers
}

final class CarriersService: BasicService, CarrierServiceProtocol {
    
    func getCarriers(code: String) async throws -> Carriers {
        
        let response = try await client.getCarrier(query: .init(
            apikey: self.apikey,
            code: code
        ))
        return try response.ok.body.json
    }
}
