//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var path: [ViewPath] = []
    
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
                case .citiesView:
                    @StateObject var citiesViewModel = CitySelectorViewModel()
                    
                    SelectorView(title: "Выбор города",
                                 viewModel: citiesViewModel)
                case .stationsView:
                    Text ("Stations")
                case .routesView:
                    Text ("Routes")
                case .timeSlotsView:
                    Text ("timeSlots")
                }
                
            }
        }
    }
}

#Preview {
    MainTabView()
}
