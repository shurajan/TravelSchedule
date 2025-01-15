//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 15.01.2025.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var path: [ViewPath]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Время отправления
                Text("Время отправления")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(themeViewModel.textColor)
                
                ForEach(Date.TimeOfDay.allCases, id: \.self) { timeOfDay in
                    HStack {
                        Text(timeOfDay.description)
                            .foregroundColor(themeViewModel.textColor)
                        Spacer()
                        CheckBoxView(isChecked: Binding(
                            get: { tripViewModel.TimeOfDay.contains(timeOfDay) },
                            set: { isChecked in
                                if isChecked {
                                    tripViewModel.TimeOfDay.append(timeOfDay)
                                } else {
                                    tripViewModel.TimeOfDay.removeAll { $0 == timeOfDay }
                                }
                            }
                        ))
                    }
                }
                
                Divider()
                
                // Показ вариантов с пересадками
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(themeViewModel.textColor)
                
                VStack(alignment: .leading, spacing: 8) {
                    RadioButtonView(
                        label: "Да",
                        isSelected: Binding(
                            get: { tripViewModel.isDirect },
                            set: { isSelected in
                                tripViewModel.isDirect = isSelected
                            }
                        )
                    )
                    RadioButtonView(
                        label: "Нет",
                        isSelected: Binding(
                            get: { !tripViewModel.isDirect },
                            set: { isSelected in
                                tripViewModel.isDirect = !isSelected
                            }
                        )
                    )
                }
            }
            .padding(.horizontal, 16)
        }
        .background(themeViewModel.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(themeViewModel.textColor)
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
    let tripViewModel = TripViewModel()
    tripViewModel.from = City.mockCities[0]
    tripViewModel.to = City.mockCities[1]
    tripViewModel.fromStation = City.mockCities[0].stations[0]
    tripViewModel.toStation = City.mockCities[1].stations[0]
    
    return FilterView(path: .constant([]))
        .environmentObject(tripViewModel)
        .environmentObject(ThemeViewModel())
}
