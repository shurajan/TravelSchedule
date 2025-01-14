//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @Binding var path: [ViewPath]
    
    var body: some View {
        VStack(spacing: 20) {
            StoriesCollectionView()
            DirectionSelectorView(path: $path)
            
            if let fromStation = tripViewModel.fromStation,
               let toStation = tripViewModel.toStation {
                Button(action: search) {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .frame(width: 150, height: 60)
                        .foregroundColor(ColorPalette.white(day: true).color)
                        .background(ColorPalette.blue.color)
                        .cornerRadius(16)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(themeViewModel.backgroundColor)
    }
    
    private func search() {
        path.append(.routesView)
    }
    
}

#Preview {
    ScheduleView(
        path: .constant([])
    )
    .environmentObject(ThemeViewModel())
    .environmentObject(TripViewModel())
}
