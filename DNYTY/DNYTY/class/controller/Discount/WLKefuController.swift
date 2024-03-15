//
//  WLKefuController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/24.
//

import UIKit
import WebKit

class WLKefuController: WLViewController {

    private lazy var webView: WKWebView = {
        let webView = WKWebView.init()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navView.titleLab.text = "login28".wlLocalized
        
        getSpreadUrlRequest()
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(webView)
    }
    override func layoutSubView() {
        super.layoutSubView()
        webView.snp.makeConstraints { make in
            make.top.equalTo(NAV_HEIGHT)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-50)
        }
    }
    
    func getSpreadUrlRequest() {
        WLProvider.request(.startConfig) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLStartConfigDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            print(dataModel.code ?? "")
                            if let code = dataModel.code {
                                self.webView.load(URLRequest.init(url: URL.init(string: code)!))
                            }

                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    

    

}
