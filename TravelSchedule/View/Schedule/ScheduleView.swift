//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 03.01.2025.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var path: [ViewPath]
    @Binding var from: City?
    @Binding var to: City?
    
    var body: some View {
        VStack(spacing: 20) {
            StoriesCollectionView()
            DirectionSelectorView(path: $path, from: $from, to: $to)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
}

#Preview {
    ScheduleView(
        path: .constant([]),
        from: .constant(City(name: "Москва", stations: [])),
        to: .constant(City(name: "Сочи", stations: []))
    )
}
