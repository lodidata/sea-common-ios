//
//  WLViewController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/22.
//

import UIKit

class WLViewController: ZKViewController {

    lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = ""
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(navView)
        
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        
    }

    

}
