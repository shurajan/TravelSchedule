//
//  Filter.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//


import Foundation

struct Filter: Hashable, Sendable{
    var from: String?
    var to: String?
    var timeOfDay: [Date.TimeOfDay]
    var isDirect: Bool
    
    init(from: String? = nil, to: String? = nil, timeOfDay: [Date.TimeOfDay] = [], isDirect: Bool = false) {
        self.from = from
        self.to = to
        self.timeOfDay = timeOfDay
        self.isDirect = isDirect
    }
}
