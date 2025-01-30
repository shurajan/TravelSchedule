//
//  SegmentTransformer.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 29.01.2025.
//
import Foundation

struct SegmentTransformer: Transformer {
    private var carrierViewModel: CarrierViewModel
    
    init(carrierViewModel: CarrierViewModel) {
        self.carrierViewModel = carrierViewModel
    }
    
    func transform(_ input: Segment) async -> Route? {
        guard let departureTime = input.departure,
              let arrivalTime = input.arrival
        else {
            return nil
        }
        
        let has_transfers = input.has_transfers ?? false
        
        guard
            let carrierData = input.thread?.carrier,
            let carrierCode = carrierData.code,
            let title = carrierData.title
        else { return nil}
        
        
        let carrier = Carrier(code: carrierCode,
                              name: title,
                              logo: carrierData.logo ?? "",
                              email: carrierData.email ?? "",
                              phone: carrierData.phone ?? "")
        await carrierViewModel.addCarrier(carrier: carrier)
        
        
        return Route(
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: input.duration ?? 0,
            stops: input.stops ?? "",
            isDirect: !has_transfers,
            carrierCode: carrierCode
        )
    }
}
