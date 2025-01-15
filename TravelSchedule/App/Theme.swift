//
//  theme.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI
import Combine

final class Theme: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var backgroundColor: Color {
        ColorPalette.black(day: isDarkMode).color
    }
    
    var colorScheme: ColorScheme {
        isDarkMode ? .dark : .light
    }
    
    var textColor: Color {
        ColorPalette.white(day: isDarkMode).color
    }
    
    var searchFieldBackGroundColor: Color {
        isDarkMode ?  ColorPalette.darkGray.color : ColorPalette.lightGray.color
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}
