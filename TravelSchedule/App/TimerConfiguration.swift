//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 21.01.2025.
//

import Foundation

struct TimerConfiguration {
    let imagesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        imagesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.imagesCount = imagesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(imagesCount) / secondsPerStory * timerTickInternal
    }
    
    func progress(for imageIndex: Int) -> CGFloat {
        return min(CGFloat(imageIndex) / CGFloat(imagesCount), 1)
    }
    
    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(imagesCount)), imagesCount - 1)
    }
    
    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
}
