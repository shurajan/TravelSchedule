//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var theme: Theme
    @Binding var path: [ViewPath]
    @ObservedObject var trip: Trip
    
    var body: some View {
        VStack(spacing: 20) {
            StoriesCollectionView()
            DirectionSelectorView(path: $path, trip: trip)
            
            if let fromStation = trip.fromStation,
               let toStation = trip.toStation {
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
        .background(theme.backgroundColor)
    }
    
    private func search() {
        path.append(.routesView)
    }
    
}

#Preview {
    ScheduleView(
        path: .constant([]),
        trip: Trip()
    )
    .environmentObject(Theme())
    //.environmentObject(Trip())
}
