//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var path: [ViewPath]
    @EnvironmentObject var tripViewModel: TripViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel
    
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
}
