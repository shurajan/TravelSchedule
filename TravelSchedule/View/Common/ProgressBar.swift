//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 21.01.2025.
//

import SwiftUI

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius:  AppViewConstants.ProgressBar.progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: AppViewConstants.ProgressBar.progressBarHeight)
                    .foregroundColor(AppColors.white.color)
                
                RoundedRectangle(cornerRadius: AppViewConstants.ProgressBar.progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: AppViewConstants.ProgressBar.progressBarHeight
                    )
                    .foregroundColor(AppColors.blue.color)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: AppViewConstants.ProgressBar.progressBarCornerRadius)
            .frame(height: AppViewConstants.ProgressBar.progressBarHeight)
            .fixedSize(
                horizontal: false,
                vertical: true)
            .foregroundStyle(AppColors.white.color)
    }
}

#Preview {
    AppColors.gray.color
        .ignoresSafeArea()
        .overlay(
            VStack(spacing: 10) {
                ProgressBar(numberOfSections: 5, progress: 0.5)
                    .padding()
                
                MaskView(numberOfSections: 5)
                    .padding()
                
                MaskFragmentView()
                    .padding()
            }
        )
}
