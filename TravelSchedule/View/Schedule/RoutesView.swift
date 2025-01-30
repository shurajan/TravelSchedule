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
    
    @State private var viewState: ViewState = .loading
    
    var body: some View {
        ZStack(alignment: .bottom) {
            theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Text(trip.text())
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(theme.textColor)
                
                contentView()
            }
            .padding(.horizontal, 16)
            
            filterButton()
        }
        .toolbarBackground(theme.backgroundColor, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton()
            }
        }
        .task {
            await loadRoutes()
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        switch viewState {
        case .loading:
            Spacer()
                .overlay {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: theme.textColor))
                }
            
        case .success:
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 8) {
                    ForEach(routeViewModel.filteredRoutes) { route in
                        if let carrier = carrierViewModel.findCarrier(by: route.carrierCode) {
                            RouteView(route: route, carrier: carrier)
                                .onTapGesture {
                                    handleRouteSelection(route)
                                }
                        }
                    }
                }
            }
            
        case .empty:
            Spacer()
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(theme.textColor)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func filterButton() -> some View {
        Button(action: {
            handleFilterButtonTap()
        }) {
            HStack {
                Text("Уточнить время")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(AppColors.white.color)
                
                let hasFilter = trip.isDirect != nil || !trip.TimeOfDay.isEmpty
                if hasFilter {
                    Circle()
                        .fill(AppColors.red.color)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
            .background(AppColors.blue.color)
            .cornerRadius(16)
        }
        .padding(.bottom, 24)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func backButton() -> some View {
        Button {
            path.removeLast()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(theme.textColor)
        }
    }
    
    private func loadRoutes() async {
        await routeViewModel.loadRoutesList()
        viewState = routeViewModel.filteredRoutes.isEmpty ? .empty : .success
    }
    
    private func handleRouteSelection(_ route: Route) {
        if let carrier = carrierViewModel.findCarrier(by: route.carrierCode) {
            path.append(.carrierView(carrier))
        }
    }
    
    private func handleFilterButtonTap() {
        path.append(.filterView)
    }
}
