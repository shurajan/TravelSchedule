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
    @EnvironmentObject var errorService: ErrorService
    
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
                    // MARK: - Вкладка с расписанием
                    Group {
                        if let error = errorService.error {
                            errorView(for: error)
                        } else {
                            ScheduleView(path: $path)
                        }
                    }
                    .tabItem {
                        Image("Schedule")
                            .renderingMode(.template)
                    }
                    
                    // MARK: - Вкладка настроек
                    Group {
                        if let error = errorService.error {
                            errorView(for: error)
                        } else {
                            SettingsView()
                        }
                    }
                    .tabItem {
                        Image("Settings")
                            .renderingMode(.template)
                    }
                }
                .accentColor(themeViewModel.textColor)
                .environment(\.colorScheme, themeViewModel.colorScheme)
                
                Divider()
                    .background(ColorPalette.gray.color)
                    .frame(height: 1)
                    .padding(.bottom, 49)
            }
            .navigationDestination(for: ViewPath.self) { id in
                NavigationHandler(
                    tripViewModel: tripViewModel,
                    path: $path,
                    citiesViewModel: citiesViewModel
                ).destination(for: id)
            }
        }
    }
    
    private func errorView(for error: AppError) -> some View {
        switch error {
        case .networkError(_):
            return AnyView(NetworkErrorView())
        case .serverError(_):
            return AnyView(ServerErrorView())
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(TripViewModel())
        .environmentObject(ThemeViewModel())
        .environmentObject(ErrorService())
}
