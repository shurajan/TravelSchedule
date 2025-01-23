//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct StoryCollectionView: View {
    @EnvironmentObject var theme: Theme
    @Binding var path: [ViewPath]
    @ObservedObject var viewModel: StoryViewModel
    @State private var storiesPresentationIsOn = false
    @State private var currentStoryIndex: Int = 0
    @State private var previousStoryIndex: Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories.indices, id: \.self) { index in
                    StoryPreview(story: viewModel.stories[index])
                        .onTapGesture {
                            didTapStory(at: index)
                        }
                        .onChange(of: currentStoryIndex) { newValue in
                            didChangeCurrentIndex(newIndex: newValue)
                        }
                        .fullScreenCover(isPresented: $storiesPresentationIsOn, onDismiss: didDismiss) {
                            StoriesView(viewModel: viewModel, currentStoryIndex: $currentStoryIndex)
                        }
                }
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
        .frame(height: 188)
    }
    
    func didTapStory(at index: Int) {
        storiesPresentationIsOn = true
        previousStoryIndex = index
        currentStoryIndex = index
    }
    
    private func didChangeCurrentIndex(newIndex: Int) {
        print("\(previousStoryIndex) -> \(newIndex)")
        guard previousStoryIndex != newIndex else {return}

        viewModel.markAsRead(at: previousStoryIndex)
        previousStoryIndex = newIndex
    }
    
    func didDismiss() {
        storiesPresentationIsOn = false
    }
}

#Preview {
    let viewModel = StoryViewModel(stories: Story.mockStories)
    StoryCollectionView(path: .constant([]), viewModel: viewModel)
        .environmentObject(Theme())
}
