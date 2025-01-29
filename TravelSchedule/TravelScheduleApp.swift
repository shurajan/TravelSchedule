//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.12.2024.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var theme: Theme
    @StateObject private var errorService: ErrorService
    @StateObject private var networkClientService: NetworkClientService
    @StateObject private var appViewModel: ApplicationViewModel
    
    init() {
        let theme = Theme()
        let errorService = ErrorService()
        let networkClientService = NetworkClientService.create()
        
        _theme = StateObject(wrappedValue: theme)
        _errorService = StateObject(wrappedValue: errorService)
        _networkClientService = StateObject(wrappedValue: networkClientService)
        _appViewModel = StateObject(wrappedValue: ApplicationViewModel(networkClient: networkClientService, errorService: errorService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .environmentObject(errorService)
                .environmentObject(networkClientService)
                .environmentObject(appViewModel)
        }
    }
}
