//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import Foundation


final class StoriesViewModel: ObservableObject {
    @Published var stories: [Story]
    
    init(stories: [Story]) {
        self.stories = stories
    }
}
