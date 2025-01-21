//
//  StoryImageView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 21.01.2025.
//


import SwiftUI

struct StoryImageView: View {
    let story: Story
    @Binding var currentImageIndex: Int
    
    var body: some View {
        TabView(selection: $currentImageIndex) {
            ForEach(story.imageNames.indices, id: \.self) { index in
                Image(story.imageNames[index])
                    .resizable()
                    .scaledToFit()
                    .tag(index)
                    .onTapGesture {
                        currentImageIndex = min(currentImageIndex + 1, story.imageNames.count - 1)
                    }
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
