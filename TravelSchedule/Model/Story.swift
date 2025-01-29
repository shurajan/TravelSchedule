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
    let description: String
    let text: String
    var isWatched: Bool
    
    mutating func setWatched() {
        isWatched = true
    }
}

extension Story {
    static let mockStories: [Story] = [
        Story(
            id: 0,
            previewImageName: "preview_1",
            imageNames: ["1", "2"],
            description: "Discover the magical sunrise over the mountains.",
            text: "The day began with a breathtaking sunrise, painting the sky with shades of orange and pink. The crisp morning air carried the scent of pine trees, and the sound of birds chirping added to the serene atmosphere. It was a perfect moment to reflect and appreciate the beauty of nature.",
            isWatched: false
        ),
        Story(
            id: 1,
            previewImageName: "preview_2",
            imageNames: ["3", "4"],
            description: "Explore the vibrant city streets at night.",
            text: "The bustling city streets came alive with lights and sounds, offering endless adventures. Street vendors served delicious food, while musicians played soulful tunes on every corner. The energy of the city was contagious, making every moment unforgettable.",
            isWatched: false
        ),
        Story(
            id: 2,
            previewImageName: "preview_3",
            imageNames: ["5", "6"],
            description: "Dive into the serenity of a calm beach.",
            text: "Waves gently kissed the shore as the sun dipped below the horizon, creating a peaceful retreat. The golden sand felt warm underfoot, and the sound of the ocean was soothing to the soul. It was a place where worries melted away, leaving only tranquility.",
            isWatched: false
        ),
        Story(
            id: 3,
            previewImageName: "preview_4",
            imageNames: ["7", "8"],
            description: "Hike through dense and mysterious forests.",
            text: "The forest was alive with the sounds of nature, each step revealing new secrets. Sunlight filtered through the dense canopy, creating patterns on the forest floor. Hidden trails led to sparkling streams and vibrant flora, making the journey both challenging and rewarding.",
            isWatched: false
        ),
        Story(
            id: 4,
            previewImageName: "preview_5",
            imageNames: ["9", "10"],
            description: "Journey to ancient ruins filled with history.",
            text: "The ancient ruins stood as a testament to a long-forgotten civilization, whispering stories of the past. Each stone seemed to hold a secret, and exploring the site felt like stepping back in time. The air was thick with mystery, inviting endless curiosity and wonder.",
            isWatched: false
        ),
        Story(
            id: 5,
            previewImageName: "preview_6",
            imageNames: ["11", "12"],
            description: "Feel the thrill of high-speed racing.",
            text: "Engines roared and adrenaline surged as the racers sped towards the finish line. The crowd cheered with excitement, their energy fueling the intense competition. Every turn and straightaway brought heart-pounding action, making it an unforgettable spectacle.",
            isWatched: false
        ),
        Story(
            id: 6,
            previewImageName: "preview_7",
            imageNames: ["13", "14"],
            description: "Enjoy a quiet evening in a cozy cabin.",
            text: "The warm glow of the fire illuminated the cabin, providing comfort on a chilly evening. Outside, snow gently fell, blanketing the world in silence. Inside, the aroma of hot cocoa and the crackling of the fire created a perfect haven of relaxation.",
            isWatched: false
        ),
        Story(
            id: 7,
            previewImageName: "preview_8",
            imageNames: ["15", "16"],
            description: "Soar above the clouds in a hot air balloon.",
            text: "The world below seemed tiny as the hot air balloon floated gracefully through the sky. The horizon stretched endlessly, offering breathtaking views of valleys and rivers. The gentle sway of the balloon added to the surreal experience of flying among the clouds.",
            isWatched: false
        ),
        Story(
            id: 8,
            previewImageName: "preview_9",
            imageNames: ["17", "18"],
            description: "Marvel at the beauty of a starry night.",
            text: "Under the vast expanse of stars, the night felt infinite and full of possibilities. Each constellation told a story, connecting the past with the present. The cool night breeze and the quiet serenity made it a perfect moment to dream and wonder.",
            isWatched: false
        )
    ]
}
