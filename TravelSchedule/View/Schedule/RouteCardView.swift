//
//  RouteCardView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 13.01.2025.
//

import SwiftUI

struct RouteCardView: View {
    let route: Route
    let carrier: Carrier
        
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
                            .foregroundColor(ColorPalette.black(day: true).color)
                        
                        Spacer()
                        
                        Text(route.departureTime.dayMonthString)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(ColorPalette.black(day: true).color)
                    }
                    
                    if route.stations.count > 2 {
                        Text("С пересадкой в \(route.stations[1])")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(ColorPalette.red.color)
                    }
                }
    
            }
        
            
            HStack {
                Text(route.departureTime.shortTimeString)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(ColorPalette.black(day: true).color)
 
                
                Rectangle()
                    .fill(ColorPalette.gray.color)
                    .frame(height: 2)
                
                Text(route.durationText(from: route.duration))
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(ColorPalette.black(day: true).color)
                    
                
                Rectangle()
                    .fill(ColorPalette.gray.color)
                    .frame(height: 2)
    
                Text(route.arrivalTime.shortTimeString)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(ColorPalette.black(day: true).color)

            }
            
        }
        .padding()
        .background(ColorPalette.lightGray.color)
        .cornerRadius(24)
        .frame(height: 90)
    }
}

#Preview {
    let carrier1 = Carrier(name: "РЖД", logo: "rzd", email: "i.lozgkina@rzd.ru", phone: "+7 (901) 111-11-11")
    let route1 =  Route(
        stations: ["Москва", "Костроме", "Санкт-Петербург"],
        departure: "2025-01-14T22:30:00+03:00",
        arrival: "2025-01-15T08:15:00+03:00",
        duration: 20 * 3600,
        carrierID: Carrier.mockCarriers[0].id
    )
    
    let carrier2 = Carrier(name: "РЖД", logo: "ural", email: "i.lozgkina@rzd.ru", phone: "+7 (901) 111-11-11")
    let route2 =  Route(
        stations: ["Москва", "Санкт-Петербург"],
        departure: "2025-01-14T22:30:00+03:00",
        arrival: "2025-01-15T08:15:00+03:00",
        duration: 15 * 3600,
        carrierID: Carrier.mockCarriers[0].id
    )
    
    VStack (spacing: 8) {
        RouteCardView(route: route1, carrier: carrier1)
        Spacer().frame(height: 8)
        RouteCardView(route: route2, carrier: carrier2)
    }
}
