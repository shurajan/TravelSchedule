//
//  NavigationHandler.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

struct NavigationHandler {
    @Binding var path: [ViewPath]
    @ObservedObject var trip: Trip
    var citiesViewModel: SelectorViewModel<City>
    var carrierViewModel: CarrierViewModel
    
    @ViewBuilder
    func destination(for id: ViewPath) -> some View {
        switch id {
        case .citiesFromView:
            selectorView(
                title: "Выбор города",
                emptyListText: "Город не найден",
                viewModel: citiesViewModel,
                onItemTap: { newItem in
                    trip.from = newItem
                    path.append(.stationsFromView)
                }
            )
        case .citiesToView:
            selectorView(
                title: "Выбор города",
                emptyListText: "Город не найден",
                viewModel: citiesViewModel,
                onItemTap: { newItem in
                    trip.to = newItem
                    path.append(.stationsToView)
                }
            )
        case .stationsFromView:
            if let from = trip.from {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: from.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        trip.fromStation = newItem
                        path.removeAll()
                    }
                )
            } 
        case .stationsToView:
            if let to = trip.to {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: to.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        trip.toStation = newItem
                        path.removeAll()
                    }
                )
            }
        case .routesView:
            let routeViewModel = RouteViewModel(trip: trip)
            RoutesView(path: $path, trip: trip, carrierViewModel: carrierViewModel, routeViewModel: routeViewModel)
                .navigationBarBackButtonHidden(true)
            
        case .carrierView(let carrier):
            CarrierView(path: $path, carrier: carrier)
                .navigationBarBackButtonHidden(true)
            
        case .filterView:
            FilterView(path: $path, trip: trip)
                .navigationBarBackButtonHidden(true)
        }
    }
    
    private func selectorView<Item: Identifiable>(
        title: String,
        emptyListText: String,
        viewModel: SelectorViewModel<Item>,
        onItemTap: @escaping (Item) -> Void
    ) -> some View {
        SelectorView(
            path: $path,
            title: title,
            notification: emptyListText,
            viewModel: viewModel,
            onItemTap: onItemTap
        )
        .navigationBarBackButtonHidden(true)
    }
    
}
