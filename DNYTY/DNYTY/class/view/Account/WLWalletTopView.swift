//
//  WLWalletTopView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLWalletTopView: UIView {

    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "account2".wlLocalized
        return lab
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "7F4FE8")
        lab.font = kSystemFont(28)
        lab.text = "-"
        return lab
    }()
    lazy var refreshBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "refresh_black"), for: .normal)
        return btn
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
        btn.setTitle("wallet0".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "#EDEEF3")
        addSubview(titleLab)
        addSubview(amountLab)
        addSubview(refreshBtn)
        addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(25)
        }
        amountLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-20)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        refreshBtn.snp.makeConstraints { make in
            make.left.equalTo(amountLab.snp.right).offset(10)
            make.centerY.equalTo(amountLab)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-10)
            make.height.equalTo(45)
        }
    }
    
}
