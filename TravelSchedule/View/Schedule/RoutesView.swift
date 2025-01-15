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
    @ObservedObject var carrierViewModel: CarrierViewModel
    @ObservedObject var routeViewModel: RouteViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text(tripViewModel.text())
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(themeViewModel.textColor)
                
                if !routeViewModel.filteredRoutes.isEmpty {
                    Spacer().frame(height: 16)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 8) {
                            ForEach(routeViewModel.filteredRoutes) { route in
                                if let carrier = carrierViewModel.findByID(route.carrierID) {
                                    RouteView(route: route, carrier: carrier)
                                        .onTapGesture {
                                            handleRouteSelection(route)
                                        }
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(themeViewModel.textColor)
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    handleFilterButtonTap()
                }) {
                    Text("Уточнить время")
                        .font(.system(size: 17, weight: .bold))
                        .frame(maxWidth: .infinity, minHeight: 60,  maxHeight: 60)
                        .foregroundColor(ColorPalette.white(day: true).color)
                        .background(ColorPalette.blue.color)
                        .cornerRadius(16)
                }
                .padding(.bottom, 24)
            }
        }
        .background(themeViewModel.backgroundColor)
        .padding(.horizontal, 16)
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
    
    private func handleRouteSelection(_ route: Route) {
        if let carrier = carrierViewModel.findByID(route.carrierID) {
            path.append(.carrierView(carrier))
        }
    }
    
    private func handleFilterButtonTap() {
        path.append(.filterView)
    }
}

#Preview {
    let tripViewModel = TripViewModel()
    tripViewModel.from = City.mockCities[0]
    tripViewModel.to = City.mockCities[1]
    tripViewModel.fromStation = City.mockCities[0].stations[0]
    tripViewModel.toStation = City.mockCities[1].stations[0]
    
    let carrierViewModel = CarrierViewModel()
    let routeViewModel = RouteViewModel(tripViewModel: tripViewModel)
    
    return RoutesView(path: .constant([]), carrierViewModel: carrierViewModel, routeViewModel: routeViewModel)
        .environmentObject(tripViewModel)
        .environmentObject(ThemeViewModel())
}
