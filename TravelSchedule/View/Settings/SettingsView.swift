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
                            .foregroundColor(themeViewModel.textColor)
                        Spacer()
                        Toggle("", isOn: $themeViewModel.isDarkMode)
                            .labelsHidden()
                            .tint(ColorPalette.blue.color)
                    }
                    .padding()
                    
                    NavigationLink(destination: Text("Тут будет текст соглашения")) {
                        HStack {
                            Text("Пользовательское соглашение")
                                .foregroundColor(themeViewModel.textColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(themeViewModel.textColor)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                        .font(.footnote)
                        .foregroundColor(themeViewModel.textColor)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 24)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
