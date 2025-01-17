//
//  Station.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//

import Foundation

struct Station: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let code: String
}
