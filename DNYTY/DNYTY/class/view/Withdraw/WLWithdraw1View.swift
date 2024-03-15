//
//  WLWithdraw1View.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit

class WLWithdraw1View: UIView {

    lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View()
        return aView
    }()
    
    private lazy var leftLab: UILabel = {
        let lab = UILabel()
        lab.text = "withdraw1".wlLocalized + "/"
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(16)
        return lab
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.text = "-"
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(28)
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
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("withdraw2".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(navView)
        addSubview(leftLab)
        addSubview(amountLab)
        addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(NAV_HEIGHT)
            make.top.equalTo(0)
        }
        leftLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(navView.snp.bottom).offset(20)
        }
        amountLab.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(leftLab.snp.bottom).offset(5)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(amountLab.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
    }
}


class WLWithdrawNav2View: UIView {
    lazy var backBtn: UIButton = {
        let icon = UIButton.init(type: .custom)
        icon.setImage(UIImage.init(named: "back_gray"), for: .normal)
        return icon
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kMediumFont(16)
        return lab
    }()
    lazy var rightBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = kSystemFont(14)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLab)
        addSubview(backBtn)
        addSubview(rightBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalToSuperview().offset(5)
            make.width.height.equalTo(40)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backBtn)
        }
        
        rightBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(backBtn)
        }
    }
}
