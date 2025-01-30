//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import Foundation

@MainActor
final class CarrierViewModel: ObservableObject {
    private var carriers: [Carrier] = []
    
    func addCarrier(carrier: Carrier) async {
        if findCarrier(by: carrier.code) == nil {
            //TODO: load image url - carrier.logo
            carriers.append(carrier)
        }
    }
    
    func findCarrier(by code: Int) -> Carrier? {
        return carriers.first { $0.code == code }
    }
}
