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
        NavigationView {
            ZStack {
                theme.backgroundColor
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Время отправления")
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(theme.textColor)
                        
                        ForEach(Date.TimeOfDay.allCases, id: \.self) { timeOfDay in
                            HStack {
                                Text(timeOfDay.description)
                                    .foregroundColor(theme.textColor)
                                    .font(.system(size: 17, weight: .regular))
                                    .multilineTextAlignment(.leading)
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
                        
                        Text("Показывать варианты с пересадками")
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(theme.textColor)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            RadioButtonView(
                                label: "Да",
                                isSelected: Binding(
                                    get: { trip.isDirect == false },
                                    set: { isSelected in
                                        if isSelected {
                                            trip.isDirect = false
                                        }
                                    }
                                )
                            )
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(theme.textColor)
                            
                            RadioButtonView(
                                label: "Нет",
                                isSelected: Binding(
                                    get: { trip.isDirect == true },
                                    set: { isSelected in
                                        if isSelected {
                                            trip.isDirect = true
                                        }
                                    }
                                )
                            )
                            .font(.system(size: 17, weight: .regular))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(theme.textColor)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .toolbarBackground(theme.backgroundColor, for: .navigationBar)
            .environment(\.colorScheme, theme.colorScheme)
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
}

struct CheckBoxView: View {
    @EnvironmentObject var theme: Theme
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(theme.textColor)
        }
        .buttonStyle(BorderlessButtonStyle())
        .frame(height: 60)
    }
}

struct RadioButtonView: View {
    @EnvironmentObject var theme: Theme
    let label: String
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(theme.textColor)
            Spacer()
            Button(action: {
                isSelected = true
            }) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(theme.textColor)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .frame(height: 60)
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
