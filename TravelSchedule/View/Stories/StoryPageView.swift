//
//  StoryPageView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 22.01.2025.
//

import SwiftUI

struct StoryPageView: View {
    let image: String
    let text: String
    
    var body: some View {
        GeometryReader { geometry in
            AppColors.black.color
                .ignoresSafeArea() // Фон полностью игнорирует safe area
                .overlay {
                    ZStack(alignment: .bottom) {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .cornerRadius(40)
                            .clipped()
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(text)
                                .foregroundColor(.white)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.bottom, 16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
        }
    }
}
