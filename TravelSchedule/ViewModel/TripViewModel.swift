//
//  TripViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

final class TripViewModel: ObservableObject {
    @Published var from: City?
    @Published var to: City?
    
    @Published var stationsFrom: Station?
    @Published var stationsTo: Station?
    
    func invert() {
        (from, to) = (to, from)
        (stationsFrom, stationsTo) = (stationsTo, stationsFrom)
    }
}
