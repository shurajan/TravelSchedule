//
//  ErrorHandler.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 12.01.2025.
//

import SwiftUI

enum AppError: Identifiable, Error {
    case serverError(message: String)
    case networkError(message: String)
    
    var id: UUID {
        UUID()
    }
    
    var message: String {
        switch self {
        case .serverError(let message), .networkError(let message):
            return message
        }
    }
}

final class ErrorService: ObservableObject {
    @Published var error: AppError? = nil
    
    func showError(_ error: AppError) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
    
    func dismissError() {
        DispatchQueue.main.async {
            self.error = nil
        }
    }
}
