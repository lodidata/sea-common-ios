//
//  WLLoginBtnsView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/7.
//

import UIKit

class WLLoginBtnsView: UIView {

    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 30, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var loginBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login0".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    
    lazy var freeRegisterBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login1".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    lazy var forgetAccountBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login29".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    lazy var forgetPasswordBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login30".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(loginBtn)
        addSubview(freeRegisterBtn)
        addSubview(forgetAccountBtn)
        addSubview(forgetPasswordBtn)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(45)
        }
        freeRegisterBtn.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        forgetAccountBtn.snp.makeConstraints { make in
            make.top.equalTo(freeRegisterBtn.snp.bottom).offset(10)
            make.right.equalTo(-(kScreenWidth/2)-12)
        }
        forgetPasswordBtn.snp.makeConstraints { make in
            make.centerY.equalTo(forgetAccountBtn)
            make.left.equalTo((kScreenWidth/2)+12)
        }
    }
    
}

class WLInputWithPicCodeView: UIView {

    lazy var flag: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text = "*"
        return lab
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text = "login12".wlLocalized
        return lab
    }()
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "28273E")
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        aView.layer.borderWidth = 1
        aView.layer.borderColor = UIColor.init(hexString: "39375A")?.cgColor
        return aView
    }()
    lazy var tfd: UITextField = {
        let tfd = UITextField.init()
        tfd.textColor = .white
        tfd.font = UIFont.systemFont(ofSize: 14)
        tfd.autocapitalizationType = .none
        return tfd
    }()
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setImage(UIImage.init(named: "refresh_purple"), for: .normal)
        return btn
    }()
    
    lazy var alertLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.text = "login12".wlLocalized
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(flag)
        addSubview(titleLab)
        addSubview(bgView)
        bgView.addSubview(tfd)
        bgView.addSubview(img)
        addSubview(btn)
        addSubview(alertLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flag.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(5)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(flag.snp.right).offset(8)
            make.centerY.equalTo(flag)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.height.equalTo(45)
        }
        img.snp.makeConstraints { make in
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
            make.right.equalTo(-3)
            make.width.equalTo(86)
        }
        tfd.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.centerY.equalToSuperview()
            make.right.equalTo(img.snp.left).offset(-10)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(bgView.snp.right).offset(10)
            make.right.equalTo(-15)
            make.centerY.equalTo(bgView)
        }
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(bgView.snp.bottom).offset(5)
            make.bottom.equalTo(-5)
        }
    }
}
