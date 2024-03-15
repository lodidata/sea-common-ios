//
//  WLForgetAccountController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/8.
//

import UIKit

class WLForgetAccountController: ZKViewController {

    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white"), for: .normal)
        return btn
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "login29".wlLocalized
        lab.textColor = .white
        lab.font = kSystemFont(16)
        return lab
    }()
    private lazy var alertLab: UILabel = {
        let lab = UILabel.init()
        lab.font = kSystemFont(14)
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.text = "login27".wlLocalized
        return lab
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 30, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var findBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login26".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "171633")
    }
    
    override func initSubView() {
        view.addSubview(closeBtn)
        view.addSubview(titleLab)
        view.addSubview(alertLab)
        view.addSubview(findBtn)
    }

    override func layoutSubView() {
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.top.equalTo(view.safeAreaInsets.top).offset(25)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(64)
            make.centerX.equalToSuperview()
        }
        alertLab.snp.makeConstraints { make in
            make.top.equalTo(180)
            make.centerX.equalToSuperview()
        }
        findBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(alertLab.snp.bottom).offset(30)
            make.height.equalTo(45)
        }
    }
    

    override func bindViewModel() {
        closeBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
    }
}
