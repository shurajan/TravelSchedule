//
//  CarrierViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import Foundation

class CarrierViewModel: ObservableObject {
    private var carriers: [Carrier]
    
    init(carriers: [Carrier] = Carrier.mockCarriers) {
        self.carriers = carriers
    }

    func findByID(_ id: UUID) -> Carrier? {
        return carriers.first { $0.id == id }
    }
}
