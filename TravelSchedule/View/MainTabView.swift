//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel
    
    @State private var path: [ViewPath] = []
    @StateObject var citiesViewModel = SelectorViewModel<City>(
        allItems: City.mockCities,
        nameKeyPath: \.name
    )
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                themeViewModel.backgroundColor
                    .ignoresSafeArea()
                
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
                .accentColor(themeViewModel.accentColor)
                .environment(\.colorScheme, themeViewModel.colorScheme)
                
                Divider()
                    .background(ColorPalette.gray.color)
                    .frame(height: 1)
                    .padding(.bottom, 49)
            }
            .navigationDestination(for: ViewPath.self) { id in
                NavigationHandler(
                    tripViewModel: tripViewModel,
                    citiesViewModel: citiesViewModel,
                    path: $path
                ).destination(for: id)
            }
        }
    }
}
