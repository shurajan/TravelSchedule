//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var errorService: ErrorService
    
    var body: some View {
        NavigationView {
            ZStack {
                theme.backgroundColor
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Text("Темная тема")
                            .foregroundColor(theme.textColor)
                        Spacer()
                        Toggle("", isOn: $theme.isDarkMode)
                            .labelsHidden()
                            .tint(ColorPalette.blue.color)
                    }
                    .padding()
                    
                    NavigationLink(destination: Text("Тут будет текст соглашения")) {
                        HStack {
                            Text("Пользовательское соглашение")
                                .foregroundColor(theme.textColor)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(theme.textColor)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text("Приложение использует API «Яндекс.Расписания»\nВерсия 1.0 (beta)")
                        .font(.footnote)
                        .foregroundColor(theme.textColor)
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
        .environmentObject(Theme())
        .environmentObject(ErrorService())
}
