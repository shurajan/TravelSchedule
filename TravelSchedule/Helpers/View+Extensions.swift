//
//  View+Extensions.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 10.01.2025.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboardOnTap() -> some View {
        self.gesture(
            TapGesture().onEnded {
                self.hideKeyboard()
            }
        )
    }
}
