//
//  DirectionView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

struct DirectionSelectorView: View {
    @Binding var path: [ViewPath]
    @Binding var from: City
    @Binding var to: City
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(ColorPalette.blue.color)
                .frame(height: 128)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: - From
                    NavigationLink(value: ViewPath.citiesFromView) {
                        ZStack(alignment: .leading) {
                            if from.name.isEmpty {
                                Text("Откуда")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text(from.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .frame(width: 259, alignment: .leading)
                    }
                    
                    // MARK: - To
                    NavigationLink(value: ViewPath.citiesToView) {
                        ZStack(alignment: .leading) {
                            if to.name.isEmpty {
                                Text("Куда")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text(to.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .frame(width: 259, alignment: .leading)
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
    DirectionSelectorView(path: .constant([]),
                          from: .constant(City(name: "Москва", stations: [])),
                          to: .constant(City(name: "Сочи", stations: [])))
}
