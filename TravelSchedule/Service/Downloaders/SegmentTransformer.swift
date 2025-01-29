//
//  SegmentTransformer.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 29.01.2025.
//
import Foundation

struct SegmentTransformer: Transformer {
    func transform(_ input: Segment) -> Route? {
        guard let departureTime = input.departure,
              let arrivalTime = input.arrival
        else {
            return nil
        }
        
        let has_transfers = input.has_transfers ?? false
        
        return Route(
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: input.duration ?? 0,
            stops: input.stops ?? "",
            isDirect: !has_transfers,
            carrierID: Carrier.mockCarriers.first?.id ?? UUID()
        )
    }
}
