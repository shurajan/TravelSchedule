//
//  DirectionView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

struct DirectionSelectorView: View {
    @Binding var path: [ViewPath]
    @Binding var from: String
    @Binding var to: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(ColorPalette.blue.color)
                .frame(height: 128)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    NavigationLink(value: ViewPath.citiesFromView) {
                        TextField("Откуда", text: $from)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 17, weight: .regular))
                    }
                    
                    NavigationLink(value: ViewPath.citiesToView) {
                        TextField("Куда", text: $to)
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
    DirectionSelectorView(path: .constant([]), from: .constant("Москва"), to: .constant("Сочи"))
}
