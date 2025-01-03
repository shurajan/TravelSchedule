//
//  Story.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import Foundation

struct Story: Hashable, Identifiable {
    let id = UUID()
    let previewImageName: String
    let imageNames: [String]
    let title: String
    let text: String
    let isWatched: Bool
}
