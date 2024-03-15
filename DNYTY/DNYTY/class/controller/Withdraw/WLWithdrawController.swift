//
//  WLWithdrawController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit
import SwiftyJSON

class WLWithdrawController: ZKViewController {

    private lazy var showView: WLWithdraw1View = {
        let aView = WLWithdraw1View()
        aView.navView.titleLab.text = "withdraw0".wlLocalized
        return aView
    }()
    private lazy var alertView: WLWithdrawAlertAlphaView = {
        let aView = WLWithdrawAlertAlphaView()
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        requestWithdrawInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ZKLoginUser.shared.isLogin {
            self.navigator.show(segue: .login, sender: self)
        }
    }
    
    override func initSubView() {
        view.addSubview(showView)
    }
    
    override func layoutSubView() {
        showView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.layoutMarginsGuide)
            make.height.equalTo(260)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func bindViewModel() {
        showView.navView.backBtn.rx.tap.bind { [unowned self] _ in
            navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        showView.btn.rx.tap.bind { [unowned self] _ in
            UIApplication.appDeltegate.window?.addSubview(alertView)
            alertView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        }.disposed(by: rx.disposeBag)
        
        alertView.cancelBtn.rx.tap.bind { [unowned self] _ in
            alertView.removeFromSuperview()
        }.disposed(by: rx.disposeBag)
        alertView.goOnBtn.rx.tap.bind { [unowned self] _ in
            alertView.removeFromSuperview()
            let vc = WLWithdraw2Controller()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: rx.disposeBag)
    }
}

extension WLWithdrawController {
    func requestWithdrawInfo() {
        WLProvider.request(.wlGetWalletWithdraw) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLWalletWithdrawDataModel.init(JSON: json["data"].dictionaryObject ?? [:])  {
                            
                            self.showView.amountLab.text = dataModel.balance?.divide100().stringValue
                        }
                        
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
