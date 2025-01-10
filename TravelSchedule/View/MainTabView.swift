//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @State private var path: [ViewPath] = []
    @StateObject var citiesViewModel = SelectorViewModel<City>(
        allItems: City.mockCities,
        nameKeyPath: \.name
    )
    
    //@State var from: City? = nil
    //@State var to: City? = nil
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                TabView {
                    ScheduleView(path: $path)
                        .tabItem {
                            Image("Schedule")
                                .renderingMode(.template)
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image("Settings")
                                .renderingMode(.template)
                        }
                }
                .accentColor(ColorPalette.black(day: true).color)
                
                Divider()
                    .background(ColorPalette.gray.color)
                    .frame(height: 1)
                    .padding(.bottom, 49)
            }
            .navigationDestination(for: ViewPath.self) { id in
                switch id {
                case .citiesFromView:
                    SelectorView(path: $path,
                                 title: "Выбор города",
                                 viewModel: citiesViewModel,
                                 onItemTap: { newItem in
                        tripViewModel.from = newItem
                        path.append(.stationsFromView)
                    })
                    .navigationBarBackButtonHidden(true)
                case .citiesToView:
                    SelectorView(path: $path,
                                 title: "Выбор города",
                                 viewModel: citiesViewModel,
                                 onItemTap: { newItem in
                        tripViewModel.to = newItem
                        path.append(.stationsToView)
                    })
                    .navigationBarBackButtonHidden(true)
                case .stationsFromView:
                    if let from = tripViewModel.from {
                        let viewModel = SelectorViewModel<Station>(
                            allItems: from.stations,
                            nameKeyPath: \.name
                        )
                        SelectorView(path: $path,
                                     title: "Выбор станции",
                                     viewModel: viewModel,
                                     onItemTap: { newItem in
                            tripViewModel.stationsFrom = newItem
                            path.removeAll()
                        })
                        .navigationBarBackButtonHidden(true)
                    } else {
                        Text("TODO - Ошибка")
                    }
                case .stationsToView:
                    if let to = tripViewModel.to {
                        let viewModel = SelectorViewModel<Station>(
                            allItems: to.stations,
                            nameKeyPath: \.name
                        )
                        SelectorView(path: $path,
                                     title: "Выбор станции",
                                     viewModel: viewModel,
                                     onItemTap: { newItem in
                            tripViewModel.stationsTo = newItem
                            path.removeAll()
                        })
                        .navigationBarBackButtonHidden(true)
                    } else {
                        Text("TODO - Ошибка")
                    }
                case .routesView:
                    Text("Routes")
                case .timeSlotsView:
                    Text("Time Slots")
                }
            }
        }
    }
}
