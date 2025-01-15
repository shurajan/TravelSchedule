//
//  UserAgreementView().swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 15.01.2025.
//

import SwiftUI

struct UserAgreementView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var errorService: ErrorService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundColor(theme.textColor)
            .background(theme.backgroundColor)
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(theme.textColor)
                    }
                }
            }
            .onAppear {
                let appearance = UINavigationBarAppearance()
                
                appearance.backgroundColor = UIColor(theme.backgroundColor)
                
                appearance.shadowColor = .clear
                
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor(theme.textColor),
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold)
                ]
                
                appearance.largeTitleTextAttributes = [
                    .foregroundColor: UIColor(theme.textColor)
                ]
                
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                
                UINavigationBar.appearance().tintColor = UIColor(theme.textColor)
            }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView()
            .environmentObject(Theme())
            .environmentObject(ErrorService())
    }
}
