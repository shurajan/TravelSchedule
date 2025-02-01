//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

@MainActor
final class StoryViewModel: ObservableObject {
    @Published var stories: [Story]
    @Published var currentIndex: Int = 0
    @Published var shouldDismissStories: Bool = false
    
    init(stories: [Story]) {
        self.stories = stories
    }
    
    func getCurrentStory() -> Story {
        stories[currentIndex]
    }
        
    func moveToNextStory() {
        let nextIndex = currentIndex + 1
        if nextIndex < stories.count {
            markAsRead(at: currentIndex)
            currentIndex = nextIndex
        } else {
            markAsRead(at: currentIndex)
            shouldDismissStories = true
        }
    }
    
    func moveToPreviousStory() {
        let previousIndex = currentIndex - 1
        if previousIndex >= 0 {
            currentIndex = previousIndex
        }
    }
    
    func setCurrentIndex(to index: Int) {
        guard index >= 0 && index < stories.count else { return }
        currentIndex = index
        markAsRead(at: currentIndex)
    }
    
    func markAsRead(at index: Int) {
        guard index >= 0 && index < stories.count else { return }
        stories[index].setWatched()
    }
}
