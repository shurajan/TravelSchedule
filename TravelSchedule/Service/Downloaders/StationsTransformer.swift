//
//  StationsTransformer.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 28.01.2025.
//

struct StationsTransformer: Transformer {    
    func transform(_ input: Settlements) -> City? {
        guard let title = input.title,
              let settlementStations = input.stations,
              !title.isEmpty
        else { return nil }
        
        let stations = settlementStations.compactMap { station -> Station? in
            guard let stationTitle = station.title,
                  let stationCode = station.codes?.yandex_code,
                  !stationTitle.isEmpty,
                  !stationCode.isEmpty
            else {
                return nil
            }
            return Station(name: stationTitle, code: stationCode)
        }
        
        guard !stations.isEmpty else { return nil }
        
        return City(name: title, stations: stations)
    }
}
