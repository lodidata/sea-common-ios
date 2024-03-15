//
//  WLWithdrawAlertAlphaView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit

class WLWithdrawAlertAlphaView: UIView {

    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        aView.backgroundColor = .white
        return aView
    }()
    
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 0
        lab.font = kSystemFont(20)
        lab.textAlignment = .center
        lab.text = "withdraw3".wlLocalized
        return lab
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.setTitle("withdraw4".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(16)
        btn.backgroundColor = UIColor.init(hexString: "28273E")
        return btn
    }()

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: (kScreenWidth - 100) / 2, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var goOnBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("text5".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        addSubview(bgView)
        bgView.addSubview(titleLab)
        bgView.addSubview(cancelBtn)
        bgView.addSubview(goOnBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenWidth - 40)
            make.height.equalTo(245)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.width.equalTo(kScreenWidth - 100)
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo((kScreenWidth - 100) / 2)
            make.height.equalTo(45)
        }
        goOnBtn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.bottom.width.height.equalTo(cancelBtn)
        }
    }
}
