//
//  RoutesView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import SwiftUI

struct RoutesView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var tripViewModel: TripViewModel
    @Binding var path: [ViewPath]
    @ObservedObject var viewModel: RoutesViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text(tripViewModel.text())
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(themeViewModel.textColor)
                
                Spacer().frame(height: 16)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.filteredRoutes) { route in
                            RouteCardView(route: route, carrier: Carrier.mockCarriers[0])
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            
            VStack {
                Spacer()
                
                Button(action: {
                    print("Button tapped")
                }) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 60,  maxHeight: 60)
                        .foregroundColor(ColorPalette.white(day: true).color)
                        .background(ColorPalette.blue.color)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
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

#Preview {
    let tripViewModel = TripViewModel()
    tripViewModel.from = City.mockCities[0]
    tripViewModel.to = City.mockCities[1]
    tripViewModel.fromStation = City.mockCities[0].stations[0]
    tripViewModel.toStation = City.mockCities[1].stations[0]
    
    let viewModel = RoutesViewModel(routeFinder: RouteFinderService.shared,
                                    fromStation: City.mockCities[0].stations[0],
                                    toStation: City.mockCities[1].stations[0])
    
    
   return RoutesView(path: .constant([]), viewModel: viewModel)
        .environmentObject(tripViewModel)
        .environmentObject(ThemeViewModel())
}
