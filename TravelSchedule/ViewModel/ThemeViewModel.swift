//
//  ThemeViewModel.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI
import Combine

final class ThemeViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var backgroundColor: Color {
        ColorPalette.black(day: isDarkMode).color
    }
    
    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    
    var accentColor: Color {
        ColorPalette.white(day: isDarkMode).color
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}
