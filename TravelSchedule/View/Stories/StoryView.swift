//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryView: View {
    @ObservedObject var viewModel: StoryViewModel
    
    @State private var currentProgress: CGFloat = 0
    @State private var currentImageIndex: Int = 0
    @State private var previousImageIndex: Int = 0
    
    private var timerConfiguration: TimerConfiguration {
        TimerConfiguration(pagesCount: story.imageNames.count)
    }
    
    private var story: Story {
        viewModel.getCurrentStory()
    }
    
    var body: some View {
        GeometryReader { geometry in
            AppColors.black.color
                .ignoresSafeArea()
                .overlay {
                    ZStack(alignment: .top) {
                        TabView(selection: $currentImageIndex) {
                            ForEach(Array(story.imageNames.enumerated()), id: \.offset) { index, imageName in
                                StoryPageView(image: imageName, description: story.description, text: story.text)
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
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                viewModel.shouldDismissStories = true
                            }) {
                                Image("Close")
                                    .resizable()
                            }
                            .frame(width: 30, height: 30)
                            .padding(.top, 50)
                            .padding(.trailing, 12)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
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
        if currentProgress == 1 && newProgress == 1 {
            withAnimation {
                viewModel.moveToNextStory()
            }
        }
        
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
