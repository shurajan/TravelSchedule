//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                themeViewModel.backgroundColor
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Text("Темная тема")
                            .foregroundColor(themeViewModel.accentColor)
                        Spacer()
                        Toggle("", isOn: $themeViewModel.isDarkMode)
                            .labelsHidden()
                            .tint(ColorPalette.blue.color)
                    }
                    .padding()
                    
                    NavigationLink(destination: Text("Тут будет текст соглашения")) {
                        HStack {
                            Text("Пользовательское соглашение")
                                .foregroundColor(ColorPalette.black(day: !themeViewModel.isDarkMode).color)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(ColorPalette.black(day: !themeViewModel.isDarkMode).color)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                        .font(.footnote)
                        .foregroundColor(ColorPalette.gray.color)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)
                }
            }
            .environment(\.colorScheme, themeViewModel.colorScheme)
        }
    }
}

#Preview {
    SettingsView()
}
