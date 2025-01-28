//
//  NetworkService.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

import Foundation
import OpenAPIURLSession

final class NetworkClientService {
    let client: Client
    
    init(timeout: TimeInterval = 120) throws {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeout
        sessionConfiguration.timeoutIntervalForResource = timeout
        
        let session = URLSession(configuration: sessionConfiguration)
        
        let transportConfiguration = URLSessionTransport.Configuration(session: session)
        
        let transport = URLSessionTransport(configuration: transportConfiguration)
        
        self.client = Client(
            serverURL: try Servers.Server1.url(),
            transport: transport
        )
    }
    
}
