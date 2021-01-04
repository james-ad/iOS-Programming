//
//  WebViewViewController.swift
//  WorldTrotter
//
//  Created by James Dunn on 1/2/21.
//

import WebKit

class WebViewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let webView = WKWebView()
        view = webView
        
        let topConstraint = webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = webView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomConstraint = webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        bottomConstraint.isActive = true
        
        let request = URLRequest(url: URL.init(string: "https://www.bignerdranch.com")!)
        
        webView.load(request)
    }
}
