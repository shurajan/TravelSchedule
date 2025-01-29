//
//  RouteCardView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import SwiftUI

struct RouteView: View {
    let route: Route
    let carrier: Carrier
    
    private let departureTime: Date
    private let arrivalTime: Date
    
    init(route: Route, carrier: Carrier) {
        self.route = route
        self.carrier = carrier
        self.departureTime = Date.ISODateFormatter.date(from: route.departureTime) ?? Date()
        self.arrivalTime = Date.ISODateFormatter.date(from: route.arrivalTime) ?? Date()
    }
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(carrier.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer().frame(width: 8)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(carrier.name)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(AppColors.black.color)
                        
                        Spacer()
                        
                        Text(departureTime.dayMonthString)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(AppColors.black.color)
                            .padding(.trailing, 8)
                    }
                    
                    if !route.isDirect {
                        Text(route.stops)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(AppColors.red.color)
                    }
                }
    
            }
            .padding(.leading, 14)
        
            
            HStack {
                Text(departureTime.shortTimeString)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(AppColors.black.color)
 
                
                Rectangle()
                    .fill(AppColors.gray.color)
                    .frame(height: 2)
                
                Text(route.durationText(from: route.duration))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(AppColors.black.color)
                    
                
                Rectangle()
                    .fill(AppColors.gray.color)
                    .frame(height: 2)
    
                Text(arrivalTime.shortTimeString)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(AppColors.black.color)

            }
            .padding(.horizontal, 14)
        }
        .frame(height: 104)
        .background(AppColors.lightGray.color)
        .cornerRadius(24)
    }
}

#Preview {
    let carrier1 = Carrier.mockCarriers[0]
    let route1 =  Route.mockRoutes[0]
    
    let carrier2 = Carrier.mockCarriers[1]
    let route2 =  Route.mockRoutes[1]
    
    VStack (spacing: 8) {
        RouteView(route: route1, carrier: carrier1)
        RouteView(route: route2, carrier: carrier2)
    }
}
