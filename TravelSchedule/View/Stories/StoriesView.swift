//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 20.01.2025.
//

import SwiftUI

struct StoriesView: View {
    let stories: [Story]
    
    private var timerConfiguration: TimerConfiguration {
        TimerConfiguration(storiesCount: stories.count)
    }
    
    @State private var currentStoryIndex: Int = 0
    @State private var previousStoryIndex: Int = 0
    @State private var currentProgress: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: previousStoryIndex, newIndex: newValue)
                    previousStoryIndex = newValue
                }
            
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
            .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            .onChange(of: currentProgress) { newValue in
                didChangeCurrentProgress(newProgress: newValue)
            }
        }
    }
    
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        
        withAnimation {
            currentProgress = progress
        }
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        
        withAnimation {
            currentStoryIndex = index
        }
    }
}
