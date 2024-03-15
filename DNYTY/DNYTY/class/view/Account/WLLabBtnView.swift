//
//  WLLabBtnView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLLabBtnView: UIView {

    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(14)
        return lab
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
        addSubview(lab)
        addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    
}

class WLTfdBtnWithTitleView: UIView {
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        return lab
    }()
    lazy var tfd: UITextField = {
        let tfd = UITextField()
        tfd.textColor = UIColor.init(hexString: "30333A")
        tfd.font = kSystemFont(14)
        tfd.borderStyle = .none
        tfd.isEnabled = false
        return tfd
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "edit_icon"), for: .normal)
        btn.isHidden = true
        return btn
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLab)
        addSubview(tfd)
        addSubview(btn)
        addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(20)
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        tfd.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalTo(btn)
            make.right.equalTo(btn.snp.left).offset(-20)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

class WLPhoneShowView: UIView {
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        return lab
    }()
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.white
        aView.layer.cornerRadius = 2
        aView.layer.masksToBounds = true
        aView.layer.borderWidth = 1
        aView.layer.borderColor = UIColor.init(hexString: "DDDEE8")?.cgColor
        return aView
    }()
    lazy var customView: WlBtnArrowView = {
        let aView = WlBtnArrowView.init()
        aView.backgroundColor = UIColor.init(hexString: "E8E9F0")
        aView.flag.image = UIImage.init(named: "down_more_gray")
        return aView
    }()
    lazy var phoneCodeLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.text = "+"
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLab)
        addSubview(bgView)
        bgView.addSubview(customView)
        bgView.addSubview(phoneCodeLab)
        addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(20)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.width.equalTo(230)
            make.height.equalTo(35)
        }
        customView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        phoneCodeLab.snp.makeConstraints { make in
            make.left.equalTo(customView.snp.right).offset(10)
            make.top.bottom.right.equalToSuperview()
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
