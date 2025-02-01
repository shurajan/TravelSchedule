//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI
import OpenAPIURLSession

struct MainTabView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var errorService: ErrorService
    @EnvironmentObject var networkClient: NetworkClientService
    @EnvironmentObject var appViewModel: ApplicationViewModel
    
    @State private var path: [ViewPath] = []
    
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
                            ScheduleView(path: $path, trip: appViewModel.trip, storyViewModel: appViewModel.storyViewModel)
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
                    appViewModel: appViewModel,
                    networkClient: networkClient,
                    errorService: errorService
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
        .environmentObject(NetworkClientService.create())
}
