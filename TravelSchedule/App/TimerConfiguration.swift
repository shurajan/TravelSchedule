//
//  TimerConfiguration.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 21.01.2025.
//

import Foundation

struct TimerConfiguration {
    let pagesCount: Int
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat
    
    init(
        pagesCount: Int,
        secondsPerPage: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.pagesCount = pagesCount
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(pagesCount) / secondsPerPage * timerTickInternal
    }
    
    func progress(for storyIndex: Int) -> CGFloat {
        return min(CGFloat(storyIndex) / CGFloat(pagesCount), 1)
    }
    
    func index(for progress: CGFloat) -> Int {
        return min(Int(progress * CGFloat(pagesCount)), pagesCount - 1)
    }
    
    func nextProgress(progress: CGFloat) -> CGFloat {
        return min(progress + progressPerTick, 1)
    }
}
