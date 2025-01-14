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
    
    @Published var fromStation: Station?
    @Published var toStation: Station?
    
    func invert() {
        (from, to) = (to, from)
        (fromStation, toStation) = (toStation, fromStation)
    }
    
    func fromText()-> String {
        if let from, let fromStation {
            return "\(from.name) (\(fromStation.name))"
        }
        return ""
    }
    
    func toText()-> String {
        if let to, let toStation {
            return "\(to.name) (\(toStation.name))"
        }
        return ""
    }
    
    func text()->String {
        return "\(fromText()) → \(toText())"
    }
}
