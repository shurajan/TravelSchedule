//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var path: [ViewPath] = []
    @StateObject var citiesViewModel = SelectorViewModel<City>(
        allItems: City.mockCities,
        nameKeyPath: \.name
    )
    
    @State var from: City = City(name: "", stations: [])
    @State var to: City = City(name: "", stations: [])
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                TabView {
                    ScheduleView(path: $path, from: $from, to: $to)
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
                        from = newItem
                        path.append(.stationsView)
                    })
                    .navigationBarBackButtonHidden(true)
                case .citiesToView:
                    SelectorView(path: $path,
                                 title: "Выбор города",
                                 viewModel: citiesViewModel,
                                 onItemTap: { newItem in
                        to = newItem
                        path.append(.stationsView)
                    })
                    .navigationBarBackButtonHidden(true)
                case .stationsView:
                    Text("Stations")
                case .routesView:
                    Text("Routes")
                case .timeSlotsView:
                    Text("Time Slots")
                }
            }
        }
    }
}
