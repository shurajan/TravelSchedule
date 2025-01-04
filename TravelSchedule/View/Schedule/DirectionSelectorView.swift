//
//  DirectionView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//

import SwiftUI

struct DirectionSelectorView: View {
    
    @State private var from: String = ""
    @State private var to: String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(ColorPalette.blue.color)
                .frame(height: 128)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink(destination: Text("Выбор места отправления")) {
                        TextField("Откуда", text: $from)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 17, weight: .regular))
                    }
                    
                    NavigationLink(destination: Text("Выбор места назначения")) {
                        TextField("Кудв", text: $to)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 17, weight: .regular))
                    }
                }
                .padding()
                .background(ColorPalette.white(day: true).color)
                .cornerRadius(20)
                .padding(.leading, 16)
                
                Spacer()
                
                Button(action: {
                    let temp = to
                    to = from
                    from = temp
                }) {
                    ZStack {
                        Circle()
                            .fill(ColorPalette.white(day: true).color)
                            .frame(width: 44, height: 44)
                        Image("Change")
                            .renderingMode(.template)
                            .foregroundColor(ColorPalette.blue.color)
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.trailing, 16)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    DirectionSelectorView()
}
