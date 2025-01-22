//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    @Binding var currentStoryIndex: Int
    @State private var currentProgress: CGFloat = 0
    @State private var currentImageIndex: Int = 0
    @State private var previousImageIndex: Int = 0
    
    private var timerConfiguration: TimerConfiguration {
        TimerConfiguration(storiesCount: story.imageNames.count)
    }
    
    var body: some View {
        GeometryReader { geometry in
            AppColors.black.color
                .ignoresSafeArea()
                .overlay {
                    ZStack(alignment: .top) {
                        TabView(selection: $currentImageIndex) {
                            ForEach(Array(story.imageNames.enumerated()), id: \.offset) { index, imageName in
                                StoryPageView(image: imageName, text: story.text)
                                    .clipped()
                                    .tag(index)
                                    .onTapGesture {
                                        didTapImage()
                                    }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onChange(of: currentImageIndex) { newValue in
                            didChangeCurrentIndex(oldIndex: previousImageIndex, newIndex: newValue)
                            previousImageIndex = newValue
                        }
                        .background(AppColors.black.color)
                        
                        StoriesProgressBar(
                            storiesCount: story.imageNames.count,
                            timerConfiguration: timerConfiguration,
                            currentProgress: $currentProgress
                        )
                        .onChange(of: currentProgress) { newValue in
                            didChangeCurrentProgress(newProgress: newValue)
                        }
                        .padding(.top, 28)
                        .padding(.horizontal, 12)
                    }
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

        guard index != currentImageIndex else { return }
        
        withAnimation {
            currentImageIndex = index
        }
    }
    
    private func didTapImage() {
        if currentImageIndex == story.imageNames.count - 1 {
            currentProgress = 1.0
            return
        }
        
        currentImageIndex += 1
    }
}
