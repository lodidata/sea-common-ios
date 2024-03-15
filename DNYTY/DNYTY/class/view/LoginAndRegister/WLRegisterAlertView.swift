//
//  WLRegisterAlertView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/7.
//

import UIKit

class WLRegisterAlertView: UIView {

    lazy var flagBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "protocol_blank_icon"), for: .normal)
        btn.setImage(UIImage.init(named: "protocol_agree_icon"), for: .selected)
        return btn
    }()
    private lazy var lab1: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.text = "login15".wlLocalized
        return lab
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        btn.setTitle("\"" + "login16".wlLocalized + "\"", for: .normal)
        return btn
    }()
    lazy var lab2: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.isHidden = true
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.text = "login17".wlLocalized
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
    lazy var registerBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login31".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(flagBtn)
        addSubview(lab1)
        addSubview(btn)
        addSubview(lab2)
        addSubview(registerBtn)
        
        flagBtn.rx.tap.map { !self.flagBtn.isSelected
        }.bind(to: flagBtn.rx.isSelected).disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flagBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
        }
        lab1.snp.makeConstraints { make in
            make.left.equalTo(flagBtn.snp.right).offset(5)
            make.centerY.equalTo(flagBtn)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(lab1.snp.right)
            make.centerY.equalTo(flagBtn)
        }
        lab2.snp.makeConstraints { make in
            make.left.equalTo(flagBtn)
            make.top.equalTo(flagBtn.snp.bottom).offset(5)
        }
        registerBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(lab2.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
    }
    
}
