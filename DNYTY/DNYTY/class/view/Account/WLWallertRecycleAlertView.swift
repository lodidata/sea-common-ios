//
//  WLWallertRecycleAlertView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLWallertRecycleAlertView: UIView {

    
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        aView.backgroundColor = .white
        return aView
    }()
    private lazy var img: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .center
        img.image = UIImage.init(named: "transfer")
        return img
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 0
        lab.font = kSystemFont(20)
        lab.textAlignment = .center
        lab.text = "wallet1".wlLocalized + "wallet8".wlLocalized
        return lab
    }()
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.text = "wallet2".wlLocalized
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(14)
        return lab
    }()
    lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.setTitle("wallet3".wlLocalized, for: .normal)
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
        bgView.addSubview(img)
        bgView.addSubview(titleLab)
        bgView.addSubview(lab)
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
            make.height.equalTo(320)
        }
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(img.snp.bottom).offset(30)
            make.width.equalTo(kScreenWidth - 100)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(20)
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
