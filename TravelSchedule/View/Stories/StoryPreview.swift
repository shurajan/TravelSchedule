//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct StoryPreview: View {
    let story: Story
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(story.previewImageName)
                .opacity(story.isWatched ? 0.5 : 1)
                .scaledToFit()
                .frame(width: 92, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(story.isWatched ? Color.clear : AppColors.blue.color, lineWidth: 4)
                )
            
            Text(story.text)
                .font(.system(size: 12))
                .foregroundColor(AppColors.white.color)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .truncationMode(.tail)
                .frame(width: 76, height: 45, alignment: .topLeading)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
    }
}

#Preview {
    var oldStory = Story.mockStories[0]
    let newStory = Story.mockStories[1]
    oldStory.setWatched()
    
    return HStack(spacing: 16) {
        StoryPreview(story: oldStory)
        StoryPreview(story: newStory)
    }
}

