//
//  DirectionView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

struct DirectionSelectorView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var path: [ViewPath]
    
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
                            if let from = tripViewModel.from,
                               let fromStation = tripViewModel.stationsFrom {
                                Text("\(from.name) (\(fromStation.name))")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(ColorPalette.black(day: true).color)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text("Откуда")
                                    .foregroundColor(ColorPalette.gray.color)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .frame(width: 259, alignment: .leading)
                    }
                    
                    // MARK: - To
                    NavigationLink(value: ViewPath.citiesToView) {
                        ZStack(alignment: .leading) {
                            if let to = tripViewModel.to,
                               let toStation = tripViewModel.stationsTo {
                                Text("\(to.name) (\(toStation.name))")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(ColorPalette.black(day: true).color)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text("Куда")
                                    .foregroundColor(ColorPalette.gray.color)
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
                    tripViewModel.invert()
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
    DirectionSelectorView(path: .constant([]))
        .environmentObject(TripViewModel())
}
