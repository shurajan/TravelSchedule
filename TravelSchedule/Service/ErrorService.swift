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

@MainActor
final class ErrorService: ObservableObject {
    @Published var error: AppError?
    
    func showError(_ error: AppError) {
        Log.error(error: error, message: error.message)
        self.error = error
    }
    
    func dismissError() {
        self.error = nil
    }
}
