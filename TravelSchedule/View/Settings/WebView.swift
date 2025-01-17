//
//  WebView.swift
//  TravelSchedule
//
//  Created by Alexander Bralnin on 16.01.2025.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let backgroundColor: Color
    let textColor: Color
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
        Coordinator(
            onError: onError,
            backgroundColor: UIColor(backgroundColor).hexString,
            textColor: UIColor(textColor).hexString
        )
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let onError: (Error) -> Void
        let backgroundColor: String
        let textColor: String
        
        init(onError: @escaping (Error) -> Void, backgroundColor: String, textColor: String) {
            self.onError = onError
            self.backgroundColor = backgroundColor
            self.textColor = textColor
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let js = """
            document.querySelectorAll('*').forEach((element) => {
                element.style.backgroundColor = '\(backgroundColor)';
                element.style.color = '\(textColor)';
                
                // Если элемент содержит иконки (SVG)
                if (element.tagName === 'SVG' || element.querySelector('svg')) {
                    element.style.fill = '\(textColor)';
                    element.style.stroke = '\(textColor)';
                }
                
                // Кнопки и элементы с границей
                if (element.tagName === 'BUTTON' || element.tagName === 'INPUT' || element.style.borderColor) {
                    element.style.borderColor = '\(textColor)';
                }
                
                // Ссылки
                if (element.tagName === 'A') {
                    element.style.color = '\(textColor)';
                    element.style.textDecoration = 'none';
                }
                
                // Чекбоксы и радио-кнопки
                if (element.tagName === 'INPUT' && (element.type === 'checkbox' || element.type === 'radio')) {
                    element.style.accentColor = '\(textColor)';
                }
                
                // Выпадающие списки
                if (element.tagName === 'SELECT') {
                    element.style.backgroundColor = '\(backgroundColor)';
                    element.style.color = '\(textColor)';
                    element.style.borderColor = '\(textColor)';
                }
                
                // Текстовые поля
                if (element.tagName === 'TEXTAREA') {
                    element.style.backgroundColor = '\(backgroundColor)';
                    element.style.color = '\(textColor)';
                    element.style.borderColor = '\(textColor)';
                }
            });
            """
            webView.evaluateJavaScript(js, completionHandler: nil)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            onError(error)
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            onError(error)
        }
    }
}
