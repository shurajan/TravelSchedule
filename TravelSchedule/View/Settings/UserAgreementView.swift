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
    
    var body: some View {
        VStack {
            WebView(
                url: URL(string: "https://yandex.ru/legal/practicum_offer")!,
                onError: { error in
                    errorService.showError(.networkError(message: error.localizedDescription))
                    dismiss()
                }
            )
            .padding(.top, 16)
            .padding(.horizontal, 16)
            .edgesIgnoringSafeArea(.bottom)
        }
        .foregroundColor(theme.textColor)
        .background(theme.backgroundColor)
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(theme.textColor)
                }
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            
            appearance.backgroundColor = UIColor(theme.backgroundColor)
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor(theme.textColor),
                .font: UIFont.systemFont(ofSize: 17, weight: .bold)
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor(theme.textColor)
            ]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = UIColor(theme.textColor)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    let onError: (Error) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onError: onError)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let onError: (Error) -> Void
        
        init(onError: @escaping (Error) -> Void) {
            self.onError = onError
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            onError(error)
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            onError(error)
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
