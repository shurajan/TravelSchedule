//
//  NetworkErrorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        BasicErrorView(imageName: "No Internet", text: "Нет интернета")
    }
}

#Preview {
    NetworkErrorView()
        .environmentObject(Theme())
}
