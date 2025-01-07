//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var path: [ViewPath] = []
    @StateObject var citiesViewModel = CitySelectorViewModel()
    
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
                    SelectorView(path: $path,
                                 title: "Выбор города",
                                 viewModel: citiesViewModel)
                    .navigationBarBackButtonHidden(true)
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
