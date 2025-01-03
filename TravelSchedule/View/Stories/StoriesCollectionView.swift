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
            HStack(spacing: 16) {
                ForEach(viewModel.stories) { story in
                    VStack {
                        ZStack {
                            Image(story.previewImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 92, height: 140)
                                .clipShape(Rectangle())
                            if !story.isWatched {
          
                            }
                            
                            Text(story.title)
                                .font(.system(size: 12))
                                .foregroundColor(ColorPalette.white(day: true).color)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 188)
    }
}

#Preview {
    StoriesCollectionView()
}
