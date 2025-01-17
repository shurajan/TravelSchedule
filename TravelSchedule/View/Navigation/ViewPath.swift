//
//  ViewPath.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 05.01.2025.
//

enum ViewPath: Hashable {
    case citiesFromView
    case citiesToView
    case stationsFromView
    case stationsToView
    case routesView
    case filterView
    case carrierView(Carrier)
}
