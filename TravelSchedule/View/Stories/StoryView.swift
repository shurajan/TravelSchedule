//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 20.01.2025.
//

import SwiftUI

struct StoryView: View {
    // MARK: - Ваша логика и свойства
    private var timerConfiguration: TimerConfiguration { .init(imagesCount: story.imageNames.count) }
    @State var currentImageIndex: Int = 0
    @State var currentProgress: CGFloat = 0
    
    @State private var oldImageIndex: Int = 0
    @State private var oldProgress: CGFloat = 0
    
    let story: Story
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // MARK: - StoryImageView
            if #available(iOS 17.0, *) {
                StoryImageView(story: story, currentImageIndex: $currentImageIndex)
                    .onChange(of: currentImageIndex) { oldValue, newValue in
                        didChangeCurrentIndex(oldIndex: oldValue, newIndex: newValue)
                    }
            } else {
                // iOS 16 fallback
                StoryImageView(story: story, currentImageIndex: $currentImageIndex)
                    .onChange(of: currentImageIndex) { newValue in
                        didChangeCurrentIndex(oldIndex: oldImageIndex, newIndex: newValue)
                        oldImageIndex = newValue
                    }
            }
            
            // MARK: - StoryProgressBar
            if #available(iOS 17.0, *) {
                StoryProgressBar(
                    storiesCount: story.imageNames.count,
                    timerConfiguration: timerConfiguration,
                    currentProgress: $currentProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                .onChange(of: currentProgress) { _, newValue in
                    didChangeCurrentProgress(newProgress: newValue)
                }
            } else {
                // iOS 16 fallback
                StoryProgressBar(
                    storiesCount: story.imageNames.count,
                    timerConfiguration: timerConfiguration,
                    currentProgress: $currentProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
                .onChange(of: currentProgress) { newValue in
                    didChangeCurrentProgress(newProgress: newValue)
                }
            }
        }
    }
    
    // MARK: - Методы обработки изменений
    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        currentProgress = timerConfiguration.progress(for: newIndex)
    }
    
    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentImageIndex else { return }
        currentImageIndex = index
    }
}
