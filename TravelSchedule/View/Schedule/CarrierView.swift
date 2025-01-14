//
//  CarrierView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 14.01.2025.
//

import SwiftUI

struct CarrierView: View {
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @Binding var path: [ViewPath]
    var carrier: Carrier
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(carrier.logo)
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: 144)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(carrier.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(themeViewModel.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(themeViewModel.textColor)
                Text(carrier.email)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(ColorPalette.blue.color)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(themeViewModel.textColor)
                Text(carrier.phone)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(ColorPalette.blue.color)
            }
            
            Spacer()
        }
        .padding(16)
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
    let carrier = Carrier.mockCarriers[0]
    CarrierView(path: .constant([]), carrier: carrier)
        .environmentObject(ThemeViewModel())
}
