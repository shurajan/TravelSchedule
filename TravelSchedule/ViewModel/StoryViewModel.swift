//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import Foundation


final class StoryViewModel: ObservableObject {
    @Published var stories: [Story]

    init(stories: [Story]) {
        self.stories = stories
    }
    
    func markAsRead(at index: Int) {
        stories[index].setWatched()
    }
}
