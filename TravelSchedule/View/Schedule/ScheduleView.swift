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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    ScheduleView(
        path: .constant([])
    )
    .environmentObject(ThemeViewModel())
    .environmentObject(TripViewModel())
}
