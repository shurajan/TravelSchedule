//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 20.01.2025.
//

import SwiftUI

struct StoriesView: View {
    var stories: [Story]
    @State private var currentStoryIndex: Int = 0
    @State private var previousStoryIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: previousStoryIndex, newIndex: newValue)
                    previousStoryIndex = newValue
                }
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        print("New story № \(newIndex)")
    }
}
