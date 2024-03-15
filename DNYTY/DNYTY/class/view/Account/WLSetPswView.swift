//
//  WLSetPswView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLSetPswView: UIView {

    lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    private lazy var redLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.font = kSystemFont(12)
        lab.text = "*"
        return lab
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    lazy var tfd: UITextField = {
        let tfd = UITextField()
        tfd.textColor = UIColor.init(hexString: "30333A")
        tfd.font = kSystemFont(14)
        tfd.isSecureTextEntry = true
        tfd.autocapitalizationType = .none
        return tfd
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "eye_close"), for: .normal)
        btn.setImage(UIImage.init(named: "eye_open"), for: .selected)
        return btn
    }()
    
    lazy var alertBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "tanhao_gray"), for: .normal)
        btn.setTitle(" " + "new3".wlLocalized, for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "72788B"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "EDEEF3")
        addSubview(bgView)
        bgView.addSubview(redLab)
        bgView.addSubview(titleLab)
        bgView.addSubview(tfd)
        bgView.addSubview(btn)
        addSubview(alertBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        redLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(7)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(redLab.snp.right).offset(5)
            make.centerY.equalTo(redLab)
        }
        tfd.snp.makeConstraints { make in
            make.left.equalTo(redLab)
            make.top.equalTo(titleLab.snp.bottom).offset(7)
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        alertBtn.snp.makeConstraints { make in
            make.left.equalTo(bgView)
            make.top.equalTo(bgView.snp.bottom).offset(5)
        }
    }
}
