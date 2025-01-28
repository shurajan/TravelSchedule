//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import Foundation

@MainActor
final class CarrierViewModel: ObservableObject {
    private var carriers: [Carrier]
    
    init(carriers: [Carrier] = Carrier.mockCarriers) {
        self.carriers = carriers
    }

    func findCarrier(by id: UUID) -> Carrier? {
        return carriers.first { $0.id == id }
    }
}
