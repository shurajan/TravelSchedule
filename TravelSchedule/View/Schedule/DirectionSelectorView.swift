//
//  DirectionView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 04.01.2025.
//
import SwiftUI

struct DirectionSelectorView: View {
    @Binding var path: [ViewPath]
    @ObservedObject var trip: Trip
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(AppColors.blue.color)
                .frame(height: 128)
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // MARK: - From
                    NavigationLink(value: ViewPath.citiesFromView) {
                        ZStack(alignment: .leading) {
                            if let from = trip.from,
                               let fromStation = trip.fromStation {
                                Text(trip.fromText())
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(AppColors.black.color)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text("Откуда")
                                    .foregroundColor(AppColors.gray.color)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .frame(width: 259, alignment: .leading)
                    }
                    
                    // MARK: - To
                    NavigationLink(value: ViewPath.citiesToView) {
                        ZStack(alignment: .leading) {
                            if let to = trip.to,
                               let toStation = trip.toStation {
                                Text(trip.toText())
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(AppColors.black.color)
                                    .font(.system(size: 17, weight: .regular))
                            } else {
                                Text("Куда")
                                    .foregroundColor(AppColors.gray.color)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .frame(width: 259, alignment: .leading)
                    }
                }
                .padding()
                .background(AppColors.white.color)
                .cornerRadius(20)
                .padding(.leading, 16)
                
                Spacer()
                
                Button(action: {
                    trip.invert()
                }) {
                    ZStack {
                        Circle()
                            .fill(AppColors.white.color)
                            .frame(width: 44, height: 44)
                        Image("Change")
                            .renderingMode(.template)
                            .foregroundColor(AppColors.blue.color)
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
    DirectionSelectorView(path: .constant([]), trip: Trip())
}
