//
//  ViewController.swift
//  muadmin
//
//  Created by Chan Wan Leng on 19/08/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {

    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://kayashipyard.com/pn/") else {
            return
        }
        webView.configuration.userContentController.add(self, name: "scriptHandler")
        webView.load(URLRequest(url: url))
        
        webView.scrollView.bounces = true
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.refreshWebView), for: UIControl.Event.valueChanged)
        webView.scrollView.addSubview(refreshControl)
    }

    @objc func refreshWebView(sender: UIRefreshControl) {
        webView.reload()
        sender.endRefreshing()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print("Message received: \(message.name) with body: \(message.body)")
        if message.body as! String == "1" {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
        else{
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }
        
//        UIViewController.attemptRotationToDeviceOrientation()
    }
}
