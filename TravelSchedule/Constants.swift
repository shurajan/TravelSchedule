//
//  Constants.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//

import Foundation

enum APIConstants {
    static let apiKey = "05d03cb7-d988-4bb4-92cb-513b293fd349"
    static let maxJsonSize: Int = 50 * 1024 * 1024
}

enum Errors {
    enum Network : Error {
        case serverError
        case connectionError
    }
}
