//
//  NavigationHandler.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

@MainActor
struct NavigationHandler {
    @Binding var path: [ViewPath]
    let appViewModel: ApplicationViewModel
    let networkClient: NetworkClientService
    let errorService: ErrorService
    
    @ViewBuilder
    func destination(for id: ViewPath) -> some View {
        switch id {
        case .citiesFromView:
            selectorView(
                title: "Выбор города",
                emptyListText: "Город не найден",
                viewModel: appViewModel.citiesViewModel,
                onItemTap: { newItem in
                    appViewModel.citiesViewModel.searchText = ""
                    appViewModel.trip.from = newItem
                    path.append(.stationsFromView)
                }
            )
        case .citiesToView:
            selectorView(
                title: "Выбор города",
                emptyListText: "Город не найден",
                viewModel: appViewModel.citiesViewModel,
                onItemTap: { newItem in
                    appViewModel.citiesViewModel.searchText = ""
                    appViewModel.trip.to = newItem
                    path.append(.stationsToView)
                }
            )
        case .stationsFromView:
            if let from = appViewModel.trip.from {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: from.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        appViewModel.trip.fromStation = newItem
                        path.removeAll()
                    }
                )
            } 
        case .stationsToView:
            if let to = appViewModel.trip.to {
                selectorView(
                    title: "Выбор станции",
                    emptyListText: "Станция не найдена",
                    viewModel: SelectorViewModel<Station>(
                        allItems: to.stations,
                        nameKeyPath: \.name
                    ),
                    onItemTap: { newItem in
                        appViewModel.trip.toStation = newItem
                        path.removeAll()
                    }
                )
            }
        case .routesView:
            let routeViewModel = RouteViewModel(trip: appViewModel.trip, networkClient: networkClient, errorService: errorService)
            RoutesView(path: $path,
                       trip: appViewModel.trip,
                       carrierViewModel: appViewModel.carrierViewModel,
                       routeViewModel: routeViewModel)
                .navigationBarBackButtonHidden(true)
            
        case .carrierView(let carrier):
            CarrierView(path: $path, carrier: carrier)
                .navigationBarBackButtonHidden(true)
            
        case .filterView:
            FilterView(path: $path, trip: appViewModel.trip)
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
