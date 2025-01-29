//
//  NetworkService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

import Foundation
import OpenAPIURLSession

@MainActor
final class NetworkClientService: ObservableObject {
    let client: Client?
    
    private init(client: Client?) {
        self.client = client
    }
    
    static func create() -> NetworkClientService {
        do {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let transportConfiguration = URLSessionTransport.Configuration(session: session)
            let transport = URLSessionTransport(configuration: transportConfiguration)
            
            let client = try Client(
                serverURL: Servers.Server1.url(),
                transport: transport
            )
            return NetworkClientService(client: client)
        } catch {
            Log.error(error: error, message: "Ошибка при создании NetworkClientService")
            return NetworkClientService(client: nil)
        }
    }
}
