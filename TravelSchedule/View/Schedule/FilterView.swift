//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 15.01.2025.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var theme: Theme
    @Binding var path: [ViewPath]
    @ObservedObject var trip: Trip
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Время отправления
                Text("Время отправления")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(theme.textColor)
                
                ForEach(Date.TimeOfDay.allCases, id: \.self) { timeOfDay in
                    HStack {
                        Text(timeOfDay.description)
                            .foregroundColor(theme.textColor)
                        Spacer()
                        CheckBoxView(isChecked: Binding(
                            get: { trip.TimeOfDay.contains(timeOfDay) },
                            set: { isChecked in
                                if isChecked {
                                    trip.TimeOfDay.append(timeOfDay)
                                } else {
                                    trip.TimeOfDay.removeAll { $0 == timeOfDay }
                                }
                            }
                        ))
                    }
                }
                
                Divider()
                
                // Показ вариантов с пересадками
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(theme.textColor)
                
                VStack(alignment: .leading, spacing: 8) {
                    RadioButtonView(
                        label: "Да",
                        isSelected: Binding(
                            get: { trip.isDirect },
                            set: { isSelected in
                                trip.isDirect = isSelected
                            }
                        )
                    )
                    RadioButtonView(
                        label: "Нет",
                        isSelected: Binding(
                            get: { !trip.isDirect },
                            set: { isSelected in
                                trip.isDirect = !isSelected
                            }
                        )
                    )
                }
            }
            .padding(.horizontal, 16)
        }
        .background(theme.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(theme.textColor)
                }
            }
        }
    }
}

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(.black)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

// Радиокнопка
struct RadioButtonView: View {
    let label: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.black)
            Spacer()
            Button(action: {
                isSelected = true
            }) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.black)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

#Preview {
    let trip = Trip()
    trip.from = City.mockCities[0]
    trip.to = City.mockCities[1]
    trip.fromStation = City.mockCities[0].stations[0]
    trip.toStation = City.mockCities[1].stations[0]
    
    return FilterView(path: .constant([]), trip: trip)
        .environmentObject(Theme())
}
