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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories.indices, id: \.self) { index in
                    StoryPreview(story: viewModel.stories[index])
                        .onTapGesture {
                            didTapStory(at: index)
                        }
                        .fullScreenCover(isPresented: $storiesPresentationIsOn, onDismiss: didDismiss) {
                            StoriesView(viewModel: viewModel)
                                .onChange(of: viewModel.shouldDismissStories) { shouldDismiss in
                                    if shouldDismiss {
                                        storiesPresentationIsOn = false
                                    }
                                }
                        }
                }
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
        .frame(height: 188)
    }
    
    func didTapStory(at index: Int) {
        storiesPresentationIsOn = true
        viewModel.setCurrentIndex(to: index)
    }
    
    func didDismiss() {
        storiesPresentationIsOn = false
        viewModel.shouldDismissStories = false
    }
}

#Preview {
    let viewModel = StoryViewModel(stories: Story.mockStories)
    StoryCollectionView(path: .constant([]), viewModel: viewModel)
        .environmentObject(Theme())
}
