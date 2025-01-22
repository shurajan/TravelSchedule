//
//  Story.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import Foundation

struct Story: Hashable, Identifiable {
    let id: Int
    let previewImageName: String
    let imageNames: [String]
    let text: String
    var isWatched: Bool
    
    mutating func setWatched() {
        isWatched = true
    }
}


extension Story {
    static var mockStories: [Story] = [
        Story(
            id: 0,
            previewImageName: "preview_1",
            imageNames: ["1", "2"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: true
        ),
        Story(
            id: 1,
            previewImageName: "preview_2",
            imageNames: ["3", "4"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: true
        ),
        Story(
            id: 2,
            previewImageName: "preview_3",
            imageNames: ["5", "6"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 3,
            previewImageName: "preview_4",
            imageNames: ["7", "8"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 4,
            previewImageName: "preview_5",
            imageNames: ["9", "10"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 5,
            previewImageName: "preview_6",
            imageNames: ["11", "12"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 6,
            previewImageName: "preview_7",
            imageNames: ["13", "14"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 7,
            previewImageName: "preview_8",
            imageNames: ["15", "16"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            id: 8,
            previewImageName: "preview_9",
            imageNames: ["17", "18"],
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
    ]
}
