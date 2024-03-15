//
//  ZKH5ViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/24
//  
//
    

import UIKit
import WebKit



class ZKH5ViewController: ZKViewController, WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    let url: URL?
    
    
    
    //@IBOutlet weak var loadingView: ZKGameLoadingView!
//    var loading: Binder<Bool> {
//        Binder(self.loadingView) { view, isShow in
//            if isShow {
//                view.increment()
//            } else {
//                view.decrement()
//            }
//        }
//    }
    
    var webView: WKWebView!
    
//    let backItem: UIBarButtonItem = {
//        let item = UIBarButtonItem(image: RImage.navi_back(), style: .plain, target: nil, action: nil)
//        return item
//    }()
    
    init(page: ZKH5Page) {
        self.url = page.url
        //print("加载地址:", url?.absoluteString ?? "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userContentController = WKUserContentController()
        userContentController.add(self, name: "popToNative")
        userContentController.add(self, name: "popToLogin")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    override func bindViewModel() {
       
        
//        backItem.rx.tap.bind { [weak self] in
//            self?.dismiss(animated: true, completion: nil)
//        }.disposed(by: rx.disposeBag)
//
        
        
        webView.rx.loading.bind(to: rx.loading).disposed(by: rx.disposeBag)
        webView.rx.promptFail.drive{ [weak self] index in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        
        
        self.reload()
    }
    
    func reload() {
        
        guard let url = url else { return  }
        webView.load(URLRequest(url: url))
    }


    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "popToNative" { //点击H5页返回按钮,返回app
            if webView.canGoBack {
                webView.goBack()
            } else {
                self.navigator.pop(sender: self)
            }
        } else if message.name == "popToLogin" { //H5发现token失效,通过此方法告诉app，app跳至登陆页
            self.showHUDMessage("txt2".wlLocalized)
            ZKLoginUser.shared.clean()
            UIApplication.appDeltegate.presentInitialScreen()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard ZKLoginUser.shared.isLogin else { return  }
        
        let token = ZKLoginUser.shared.model.token
        webView.evaluateJavaScript(String(format: "sendToken('%@')", token)) { result, error in
            
        }
        
        
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
