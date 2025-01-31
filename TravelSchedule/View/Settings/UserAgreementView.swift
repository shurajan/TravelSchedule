//
//  UserAgreementView().swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 15.01.2025.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    @EnvironmentObject var theme: Theme
    @EnvironmentObject var errorService: ErrorService
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewState: ViewState = .loading
    @State private var userAgreementURL: URL? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(theme.textColor)
                }
                
                Spacer()
                
                Text("Пользовательское соглашение")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(theme.textColor)
                
                Spacer()
            }
            .padding(.horizontal)
            .frame(height: 44)
            .background(theme.backgroundColor)
            
            switch viewState {
            case .loading:
                Spacer()
                    .overlay {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: theme.textColor))
                    }
                
            case .success:
                if let url = userAgreementURL {
                    WebView(
                        url: url,
                        backgroundColor: theme.backgroundColor,
                        textColor: theme.textColor,
                        onError: { error in
                            errorService.showError(.networkError(message: error.localizedDescription))
                            dismiss()
                        }
                    )
                    .padding([.top, .horizontal], 16)
                    .edgesIgnoringSafeArea(.bottom)
                } else {
                    EmptyView()
                }
                
            case .empty:

                Spacer()
            }
        }
        .foregroundColor(theme.textColor)
        .background(theme.backgroundColor)
        .task {
            await loadUserAgreement()
        }
    }
    
    // MARK: - Loading agreement
    private func loadUserAgreement() async {
        guard let url = AppConstants.userAgreementURL else {
            errorService.showError(.networkError(message: "Incorrect URL"))
            dismiss()
            return
        }
        do {
            _ = try await URLSession.shared.data(from: url)
            
            userAgreementURL = url
            viewState = .success
        } catch {
            errorService.showError(.networkError(message: "Incorrect URL"))
            dismiss()
        }
    }
}


#Preview {
    NavigationStack {
        UserAgreementView()
            .environmentObject(Theme())
            .environmentObject(ErrorService())
    }
}
