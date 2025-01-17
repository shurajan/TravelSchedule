//
//  BasicErrorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 11.01.2025.
//

import SwiftUI

struct BasicErrorView: View {
    @EnvironmentObject var theme: Theme
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
                .foregroundColor(theme.textColor)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.backgroundColor)
    }
}

#Preview {
    BasicErrorView(imageName: "No Internet", text: "Нет интернета")
        .environmentObject(Theme())
        .environmentObject(ErrorService())
}
