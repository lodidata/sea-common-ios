//
//  WLDiscountDetailController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit
import WebKit
import YYText

class WLDiscountDetailController: ZKViewController {

    var dataModel: WLUserActiveListDataModel!
    private lazy var navView: WLDiscountNav2View = {
        let aView = WLDiscountNav2View()
        aView.titleLab.text = "discount1".wlLocalized
        return aView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    private lazy var infoView: WLDiscountDetailInfoView = {
        let aView = WLDiscountDetailInfoView()
        return aView
    }()
    private lazy var titleLab: YYLabel = {
        let lab = YYLabel()
        lab.font = kSystemFont(18)
        lab.textColor = UIColor.init(hexString: "D4D4D4")
        lab.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        lab.backgroundColor = UIColor.init(hexString: "171633")
        lab.numberOfLines = 0
        return lab
    }()
    private lazy var webView: WKWebView = {
        let webView = WKWebView.init()
        webView.backgroundColor = UIColor.init(hexString: "171633")
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "0E0D20")
    }
    
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(scrollView)
        scrollView.addSubview(img)
        scrollView.addSubview(infoView)
        scrollView.addSubview(titleLab)
        scrollView.addSubview(webView)
    }
    
    override func layoutSubView() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
            make.width.equalTo(kScreenWidth)
        }
        img.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(155)
            make.width.equalTo(kScreenWidth)
        }
        infoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(img.snp.bottom)
            make.height.equalTo(140)
        }
        let height = dataModel.details.heightWithText(18, 30)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.top.equalTo(infoView.snp.bottom).offset(10)
            make.height.equalTo(height+10)
        }
//        webView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(titleLab.snp.bottom).offset(10)
//            make.height.equalTo(60)
//        }
        webView.scrollView.rx.observe(CGSize.self, "contentSize").bind { [unowned self] size in
            guard let size = size else {
                return
            }
            self.webView.snp.updateConstraints { make in
                make.top.equalTo(titleLab.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(size.height)
                make.bottom.equalToSuperview()
            }
        }.disposed(by: rx.disposeBag)
    }

    override func bindViewModel() {
        img.sd_setImage(with: URL(string: dataModel.img), completed: nil)
        infoView.titleLab.text = dataModel.title
        infoView.lab2.text = dataModel.start_time + " - " + dataModel.end_time
        titleLab.text = dataModel.details
        if dataModel.state == "contact" && dataModel.type_id == 4 {
            infoView.actBtn.setTitle("discount5".wlLocalized, for: .normal)
            infoView.actBtn.setImage(UIImage.init(named: "kefu_icon"), for: .normal)
            infoView.actBtn.tag = 1
        } else if dataModel.type_id == 7 {
            infoView.actBtn.setTitle("discount4".wlLocalized, for: .normal)
            infoView.actBtn.setImage(nil, for: .normal)
            infoView.actBtn.setTitleColor(UIColor.init(hexString: "E94951"), for: .normal)
            infoView.actBtn.tag = 2
        } else {
            infoView.actBtn.setTitle("discount2".wlLocalized, for: .normal)
            infoView.actBtn.setImage(UIImage.init(named: "discount_noness_icon"), for: .normal)
            infoView.actBtn.tag = 3
        }
        navView.icon.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                self.navigationController?.popViewController()
            }.disposed(by: rx.disposeBag)
        infoView.actBtn.rx.tap.bind { [unowned self] _ in
            if infoView.actBtn.tag == 1 { //联系客服
                let vc = WLKefuController()
                navigationController?.pushViewController(vc, animated: true)
            } else if infoView.actBtn.tag == 2 { //立即申请
                requestActiveSlot()
            } else {
                
            }
        }.disposed(by: rx.disposeBag)
        
        
        let htmlStr = String(format: "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><body style=\"color: rgb(187, 192, 208)\">%@</body></html>", dataModel.text)
        webView.loadHTMLString(htmlStr, baseURL: nil)
    }
}

extension WLDiscountDetailController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.style.backgroundColor=\"#171633\"", completionHandler: nil)
    }
}

extension WLDiscountDetailController {
    func requestActiveSlot() {
        WLProvider.request(.wlActiveSlot) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.showHUDMessage(baseModel.message)
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
