//
//  ServerErrorView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        BasicErrorView(imageName: "Server Error", text: "Ошибка сервера")
    }
}

#Preview {
    ServerErrorView()
        .environmentObject(ThemeViewModel())
}
