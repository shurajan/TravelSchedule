//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView {
                    ScheduleView()
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
        }
    }
}

#Preview {
    MainTabView()
}
