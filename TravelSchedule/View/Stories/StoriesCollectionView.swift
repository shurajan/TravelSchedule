//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct StoriesCollectionView: View {
    @StateObject var viewModel = StoriesViewModel(stories: StoriesViewModel.sampleStories)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories) { story in
                    StoryView(story: story)
                }
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        }
        .frame(height: 188)
    }
}

#Preview {
    StoriesCollectionView()
}
