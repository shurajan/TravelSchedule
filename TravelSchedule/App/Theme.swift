//
//  theme.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI
import Combine

final class Theme: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    var backgroundColor: Color {
        isDarkMode ? AppColors.black.color : AppColors.white.color
    }
    
    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    
    var textColor: Color {
        isDarkMode ? AppColors.white.color : AppColors.black.color
    }
    
    var searchFieldBackgroundColor: Color {
        isDarkMode ? AppColors.darkGray.color : AppColors.lightGray.color
    }

    func toggleTheme() {
        isDarkMode.toggle()
    }
}
