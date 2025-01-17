//
//  StationsLoaderService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//
import Foundation
import OpenAPIURLSession

final class StationsLoaderService {
    
    static func stationsList(timeout: TimeInterval = 120) async throws -> [City] {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeout
        sessionConfiguration.timeoutIntervalForResource = timeout
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let transportConfiguration = URLSessionTransport.Configuration(session: session)
        
        let transport = URLSessionTransport(configuration: transportConfiguration)
        
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: transport
        )
        
        let service = StationsListService(
            client: client,
            apikey: APIConstants.apiKey
        )
        
        var cities = [City]()
        
        do {
            let stationsList = try await service.getStationsList()
            guard let countries = stationsList.countries else { throw AppError.networkError(message: "can not parse stations") }
            countries.forEach { country in
                country.regions?.forEach { region in
                    region.settlements?.forEach { settlement in
                        if let name = settlement.title, !name.isEmpty {
                            var stations = [Station]()
                            settlement.stations?.forEach { station in
                                if let stationName = station.title,
                                    !stationName.isEmpty,
                                    let code = station.codes?.yandex_code,
                                    !code.isEmpty{
                                    stations.append(Station(name: stationName, code: code))
                                }
                            }
                            cities.append(City(name: name, stations: stations))
                        }
                    }
                }
            }
        } catch {
            throw AppError.networkError(message: "can not parse stations")
        }
        return cities
    }
}
