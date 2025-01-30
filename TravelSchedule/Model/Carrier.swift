//
//  Carier.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import Foundation

struct Carrier: Hashable, Identifiable, Sendable {
    let id = UUID()
    let code: Int
    let name: String
    let logo: String
    let email: String
    let phone: String
}
