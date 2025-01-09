//
//  City.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//

import Foundation

struct City: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var stations: [Station]
}
