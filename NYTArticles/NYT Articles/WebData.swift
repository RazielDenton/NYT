//
//  WebData.swift
//  NYT Articles
//
//  Created by Raziel on 27.05.2021.
//

import WebKit

class WebData: NSObject {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    private var completionHandler: ((Result<Data, Error>) -> Void)?
    
    func createData(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        self.completionHandler = completionHandler
        webView.load(.init(url: url))
    }
    
}

extension WebData: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.createWebArchiveData { [weak self] result in
            self?.completionHandler?(result)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        completionHandler?(.failure(error))
    }
}
