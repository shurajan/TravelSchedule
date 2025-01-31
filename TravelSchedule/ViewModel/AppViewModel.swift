//
//  AppViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 29.01.2025.
//

import SwiftUI

@MainActor
final class ApplicationViewModel: ObservableObject {
    @Published var trip = Trip()
    @Published var carrierViewModel = CarrierViewModel()
    @Published var storyViewModel = StoryViewModel(stories: Story.mockStories)
    @Published var citiesViewModel: SelectorViewModel<City>
    
    init(networkClient: NetworkClientService, errorService: ErrorService) {
        self.citiesViewModel = SelectorViewModel(
            asyncItems: { await ApplicationViewModel.loadStationsList(networkClient: networkClient, errorService: errorService) },
            nameKeyPath: \.name
        )
    }
    
    private static func loadStationsList(networkClient: NetworkClientService, errorService: ErrorService) async -> [City] {
        guard let client = networkClient.client else {
            errorService.showError(AppError.networkError(message: "Cannot create client"))
            return []
        }
        
        let apiService = StationsListService(client: client, apikey: APIConstants.apiKey)
        let transformer = StationsTransformer()
        let downloader = DataDownloader(apiService: apiService.getStationsList, transformer: transformer)
        
        do {
            try await downloader.fetchData()
            return await downloader.getItems()
        } catch {
            errorService.showError(AppError.networkError(message: "Cannot load data"))
            return []
        }
    }
}
