//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var errorService: ErrorService
    
    @State private var path: [ViewPath] = []
    @StateObject private var trip: Trip = Trip()
    
    @StateObject var citiesViewModel = SelectorViewModel<City>(
        allItems: City.mockCities,
        nameKeyPath: \.name
    )
    
    @StateObject var carrierViewModel = CarrierViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                theme.backgroundColor
                    .ignoresSafeArea()
                
                TabView {
                    // MARK: - Вкладка с расписанием
                    Group {
                        if let error = errorService.error {
                            errorView(for: error)
                        } else {
                            ScheduleView(path: $path, trip: trip)
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
                .accentColor(theme.textColor)
                .environment(\.colorScheme, theme.colorScheme)
                
                Divider()
                    .background(AppColors.gray.color)
                    .frame(height: 1)
                    .padding(.bottom, 49)
            }
            .navigationDestination(for: ViewPath.self) { id in
                NavigationHandler(
                    path: $path,
                    trip: trip,
                    citiesViewModel: citiesViewModel,
                    carrierViewModel: carrierViewModel
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
        .environmentObject(Theme())
        .environmentObject(ErrorService())
}
