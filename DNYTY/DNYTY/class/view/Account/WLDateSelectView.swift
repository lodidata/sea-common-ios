//
//  WLDateSelectView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLDateSelectItemView: UIView {

    //cannder_icon
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        return lab
    }()
    lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "--"
        return lab
    }()
    private lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.image = UIImage.init(named: "cannder_icon")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.init(hexString: "DDDEE8")?.cgColor
        addSubview(lab)
        addSubview(dateLab)
        addSubview(icon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab.snp.makeConstraints { make in
            make.left.equalTo(32)
            make.top.equalTo(12)
        }
        dateLab.snp.makeConstraints { make in
            make.left.equalTo(lab)
            make.top.equalTo(lab.snp.bottom).offset(3)
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(dateLab)
        }
    }
}

class WLDateShowView: UIView {
    lazy var startView: WLDateSelectItemView = {
        let aView = WLDateSelectItemView()
        aView.lab.text = "new4".wlLocalized
        return aView
    }()
    lazy var endView: WLDateSelectItemView = {
        let aView = WLDateSelectItemView()
        aView.lab.text = "new5".wlLocalized
        return aView
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 30, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var queryBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("text6".wlLocalized, for: .normal)
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
        addSubview(startView)
        addSubview(endView)
        addSubview(queryBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        startView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo((kScreenWidth - 40) / 2)
            make.height.equalTo(54)
        }
        endView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.width.height.equalTo(startView)
        }
        queryBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-20)
            make.height.equalTo(45)
        }
    }
}
