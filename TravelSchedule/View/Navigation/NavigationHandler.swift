//
//  NavigationHandler.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

struct NavigationHandler {
    @Binding var path: [ViewPath]
    var tripViewModel: TripViewModel
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
                    tripViewModel.from = newItem
                    path.append(.stationsFromView)
                }
            )
        case .citiesToView:
            selectorView(
                title: "Выбор города",
                emptyListText: "Город не найден",
                viewModel: citiesViewModel,
                onItemTap: { newItem in
                    tripViewModel.to = newItem
                    path.append(.stationsToView)
                }
            )
        case .stationsFromView:
            if let from = tripViewModel.from {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: from.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        tripViewModel.fromStation = newItem
                        path.removeAll()
                    }
                )
            } 
        case .stationsToView:
            if let to = tripViewModel.to {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: to.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        tripViewModel.toStation = newItem
                        path.removeAll()
                    }
                )
            }
        case .routesView:
            if let fromStation = tripViewModel.fromStation,
               let toStation = tripViewModel.toStation {
                
                let routesViewModel = RouteViewModel(fromStation: fromStation,
                                                     toStation: toStation)
                RoutesView(path: $path, viewModel: routesViewModel, carrierViewModel: carrierViewModel)
                    .navigationBarBackButtonHidden(true)
            }
            
        case .carrierView(let carrier):
            CarrierView(path: $path, carrier: carrier)
            
        case .timeSlotsView:
            Text("Time Slots")
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
