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
                        .tint(AppColors.blue.color)
                }
                .padding()
                
                HStack {
                    Text("Пользовательское соглашение")
                        .foregroundColor(theme.textColor)
                    Spacer()
                    NavigationLink(destination: UserAgreementView()
                                                    .navigationBarBackButtonHidden(true)) {
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

#Preview {
    NavigationStack{
        SettingsView()
            .environmentObject(Theme())
            .environmentObject(ErrorService())
    }
}
