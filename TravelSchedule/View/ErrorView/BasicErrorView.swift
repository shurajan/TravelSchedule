//
//  BasicErrorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 11.01.2025.
//

import SwiftUI

struct BasicErrorView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var errorService: ErrorService
    
    let imageName: String
    let text: String
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 223, height: 223)
            
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 24)
                .foregroundColor(themeViewModel.textColor)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    BasicErrorView(imageName: "No Internet", text: "Нет интернета")
        .environmentObject(ThemeViewModel())
        .environmentObject(ErrorService())
}
