//
//  RoutesView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import SwiftUI

struct RoutesView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var path: [ViewPath]
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(themeViewModel.textColor)
                .background(themeViewModel.backgroundColor)
        }
        .background(themeViewModel.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(themeViewModel.textColor)
                }
            }
        }
    }
    
}

#Preview {
    RoutesView(path: .constant([]))
        .environmentObject(TripViewModel())
        .environmentObject(ThemeViewModel())
}
