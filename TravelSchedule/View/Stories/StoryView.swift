//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    @State private var currentProgress: CGFloat = 0
    @State private var currentImageIndex: Int = 0
    @State private var previousImageIndex: Int = 0
    
    private var timerConfiguration: TimerConfiguration {
        TimerConfiguration(storiesCount: story.imageNames.count)
    }
    
    var body: some View {
        AppColors.black.color
            .overlay {
                ZStack {
                    TabView(selection: $currentImageIndex) {
                        ForEach(Array(story.imageNames.enumerated()), id: \.offset) { index, image in
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .onTapGesture {
                                    didTapImage()
                                }
                                .tag(index)
                        }
                    }
                    .ignoresSafeArea()
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    if #available(iOS 17.0, *) {
                        StoriesProgressBar(
                            storiesCount: story.imageNames.count,
                            timerConfiguration: timerConfiguration,
                            currentProgress: $currentProgress
                        )
                        .padding(.top, 20)
                        .onChange(of: currentProgress) { _, newValue in
                            didChangeCurrentProgress(newProgress: newValue)
                        }
                    } else {
                        // Fallback on earlier versions
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
            print(currentImageIndex)
            currentImageIndex = index
        }
    }
    
    func didTapImage() {
        currentImageIndex = min(currentImageIndex + 1, story.imageNames.count - 1)
    }
}
