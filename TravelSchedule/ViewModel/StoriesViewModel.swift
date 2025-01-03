//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import Foundation


class StoriesViewModel: ObservableObject {
    @Published var stories: [Story]
    
    init(stories: [Story]) {
        self.stories = stories
    }
}

extension StoriesViewModel {
    static let sampleStories = [
        Story(
            previewImageName: "preview_1",
            imageNames: ["1", "2"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: true
        ),
        Story(
            previewImageName: "preview_2",
            imageNames: ["3", "4"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: true
        ),
        Story(
            previewImageName: "preview_3",
            imageNames: ["5", "6"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_4",
            imageNames: ["7", "8"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_5",
            imageNames: ["9", "10"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_6",
            imageNames: ["11", "12"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_7",
            imageNames: ["13", "14"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_8",
            imageNames: ["15", "16"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
        Story(
            previewImageName: "preview_9",
            imageNames: ["17", "18"],
            title: "Text Text",
            text: "Text Text Text Text Text Text Text Text",
            isWatched: false
        ),
    ]
}
