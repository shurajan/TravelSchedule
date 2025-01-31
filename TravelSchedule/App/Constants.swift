//
//  Constants.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 09.01.2025.
//

import Foundation

enum APIConstants {
    static let apiKey = "05d03cb7-d988-4bb4-92cb-513b293fd349"
    static let maxJsonSize: Int = 50 * 1024 * 1024
}

enum AppConstants {
    static let userAgreementURL = URL(string: "https://yandex.ru/legal/practicum_offer")
}

enum AppViewConstants {
    enum ProgressBar {
        static let progressBarCornerRadius: CGFloat = 3
        static let progressBarHeight: CGFloat = 6
    }
}
