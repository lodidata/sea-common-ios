//
//  WLHelpCenterController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/24.
//

import UIKit
import WebKit

class WLHelpCenterController: ZKViewController {

    private lazy var config: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration.init()
        let preferences = WKPreferences.init()
        preferences.javaScriptEnabled = true
        config.preferences = preferences
        let userContentController = WKUserContentController.init()
        userContentController.add(self, name: "popToNative")
        config.userContentController = userContentController
        return config
    }()

    private lazy var webView: WKWebView = {
        let webView = WKWebView.init(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = "http://192.168.5.170:8081" + "/pages/agency/index?isapp=1"
        let request = URLRequest.init(url: URL.init(string: path)!)
        webView.load(request)
    }
    

    override func initSubView() {
        super.initSubView()
        
        view.addSubview(webView)
    }
    override func layoutSubView() {
        super.layoutSubView()
        webView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-50)
        }
    }
    

}

extension WLHelpCenterController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.name:" + message.name)
        if message.name == "popToNative" {
            self.navigationController?.popViewController()
        }
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webViewDidStartLoad")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webViewDidFinishLoad")
        let token = ZKLoginUser.shared.model?.token ?? ""
        print(token)
//        let tokenStr = NSString.init(format: "%@", token)
//        let para = tokenStr.replacingOccurrences(of: "\n", with: "")
        let jsFunc = String(format: "sendToken('%@')", token)
        
        webView.evaluateJavaScript(jsFunc) { result, error in
            
        }
    }
    
}
