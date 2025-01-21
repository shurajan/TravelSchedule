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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories.indices, id: \.self) { index in
                    StoryPreview(story: viewModel.stories[index])
                        .onTapGesture {
                            didTapStory(at: index)
                        }
                }
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
        .frame(height: 188)
    }
    
    func didTapStory(at index: Int) {
        let story = viewModel.stories[index]
        print("\(viewModel.stories[index].id) - \(viewModel.stories[index].text)")
        path.append(.storyView(index))
    }
}

#Preview {
    let viewModel = StoryViewModel(stories: Story.mockStories)
    StoryCollectionView(path: .constant([]), viewModel: viewModel)
        .environmentObject(Theme())
}
