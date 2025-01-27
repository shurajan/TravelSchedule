//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 20.01.2025.
//

import SwiftUI

struct StoriesView: View {
    @ObservedObject var viewModel: StoryViewModel    
    var body: some View {
        TabView(selection: $viewModel.currentIndex) {
            ForEach(viewModel.stories) { story in
                StoryView(viewModel: viewModel)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
