//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        AppColors.black.color
            .overlay {
                ZStack {
                    Image(story.imageNames[0])
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.top, 8)
                        .padding(.horizontal, .zero)
                }
            }
    }
}
