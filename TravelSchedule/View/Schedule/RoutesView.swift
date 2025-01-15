//
//  RoutesView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//
import SwiftUI

struct RoutesView: View {
    @EnvironmentObject var theme: Theme
    @Binding var path: [ViewPath]
    @ObservedObject var trip: Trip
    @ObservedObject var carrierViewModel: CarrierViewModel
    @ObservedObject var routeViewModel: RouteViewModel
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottom) {
                theme.backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    Text(trip.text())
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(theme.textColor)
                    
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
                            .foregroundColor(theme.textColor)
                        Spacer()
                    }
                    
                }
                .padding(.horizontal, 16)
                
                VStack {
                    
                    Button(action: {
                        handleFilterButtonTap()
                    }) {
                        Text("Уточнить время")
                            .font(.system(size: 17, weight: .bold))
                            .frame(maxWidth: .infinity, minHeight: 60,  maxHeight: 60)
                            .foregroundColor(AppColors.white.color)
                            .background(AppColors.blue.color)
                            .cornerRadius(16)
                    }
                }
                .padding(.bottom, 24)
                .padding(.horizontal, 16)
            }
            .toolbarBackground(theme.backgroundColor, for: .navigationBar)
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
    let trip = Trip()
    trip.from = City.mockCities[0]
    trip.to = City.mockCities[1]
    trip.fromStation = City.mockCities[0].stations[0]
    trip.toStation = City.mockCities[1].stations[0]
    
    let carrierViewModel = CarrierViewModel()
    let routeViewModel = RouteViewModel(trip: trip)
    
    return RoutesView(path: .constant([]),
                      trip: trip,
                      carrierViewModel: carrierViewModel,
                      routeViewModel: routeViewModel)
    .environmentObject(trip)
    .environmentObject(Theme())
}
