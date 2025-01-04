//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        VStack(spacing: 20) {
            StoriesCollectionView()
            DirectionSelectorView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
}

#Preview {
    ScheduleView()
}
