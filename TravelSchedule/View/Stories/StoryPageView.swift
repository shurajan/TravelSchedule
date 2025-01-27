//
//  StoryPageView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryPageView: View {
    let image: String
    let description: String
    let text: String
    
    var body: some View {
        GeometryReader { geometry in
            AppColors.black.color
                .ignoresSafeArea()
                .overlay {
                    ZStack(alignment: .bottom) {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .cornerRadius(40)
                            .clipped()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(description)
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(AppColors.white.color)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .truncationMode(.tail)
                                .frame(height: 120, alignment: .bottomLeading)
                            
                            Text(text)
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(AppColors.white.color)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .truncationMode(.tail)
                                .frame(height: 72, alignment: .bottomLeading)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 40)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
        }
    }
}
