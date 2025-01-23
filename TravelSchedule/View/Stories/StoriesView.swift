//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 20.01.2025.
//

import SwiftUI

struct StoriesView: View {
    @ObservedObject var viewModel: StoryViewModel
    @Binding var currentStoryIndex: Int

    
    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach(viewModel.stories) { story in
                StoryView(story: story, currentStoryIndex: $currentStoryIndex)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
