//
//  WLAccountTopView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/16.
//

import UIKit

class WLAccountTopView: UIView {

    private lazy var bgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.image = UIImage.init(named: "account_top_bg")
        return img
    }()
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(14)
        lab.textColor = .white
        lab.text = "account0".wlLocalized + ",-"
        return lab
    }()
    lazy var exitBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.set(image: RImage.exit_icon(), title: "account1".wlLocalized, titlePosition: .right, additionalSpacing: 10, state: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(34)
        lab.textColor = .white
        lab.text = "-"
        return lab
    }()
    private lazy var coinLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(16)
        lab.textColor = .white
        lab.text = "PHP"
        return lab
    }()
    lazy var refreshBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "refresh_white"), for: .normal)
        return btn
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = .white
        lab.text = "account2".wlLocalized
        return lab
    }()
    lazy var funcView: WLAccountFuncView = {
        let aView = WLAccountFuncView()
        return aView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImg)
        addSubview(nameLab)
        addSubview(exitBtn)
        addSubview(amountLab)
        addSubview(coinLab)
        addSubview(refreshBtn)
        addSubview(titleLab)
        addSubview(funcView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.left.equalTo(15)
        }
        exitBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(nameLab)
        }
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(nameLab.snp.bottom).offset(25)
        }
        coinLab.snp.makeConstraints { make in
            make.left.equalTo(amountLab.snp.right).offset(5)
            make.bottom.equalTo(amountLab).offset(-5)
        }
        refreshBtn.snp.makeConstraints { make in
            make.left.equalTo(coinLab.snp.right).offset(5)
            make.centerY.equalTo(amountLab)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(amountLab.snp.bottom).offset(5)
        }
        funcView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(3)
            make.bottom.equalToSuperview()
        }
    }
}

class WLAccountFuncView: UIView {
    
    private lazy var bgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.image = UIImage.init(named: "account_top_item_bg")
        return img
    }()
    lazy var rechangeView: ImgLabVerticalView = {
        let aView = ImgLabVerticalView()
        aView.icon.image = UIImage.init(named: "rechange_icon")
        aView.lab.text = "account4".wlLocalized
        return aView
        
    }()
    lazy var withdrawView: ImgLabVerticalView = {
        let aView = ImgLabVerticalView()
        aView.icon.image = UIImage.init(named: "withdraw_icon")
        aView.lab.text = "account5".wlLocalized
        return aView
        
    }()
    lazy var noticeView: ImgLabVerticalView = {
        let aView = ImgLabVerticalView()
        aView.icon.image = UIImage.init(named: "email_icon")
        aView.lab.text = "account6".wlLocalized
        //aView.badgeLab.isHidden = false
        return aView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImg)
        addSubview(rechangeView)
        addSubview(withdrawView)
        addSubview(noticeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        withdrawView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        rechangeView.snp.makeConstraints { make in
            make.left.equalTo(55)
            make.top.bottom.width.equalTo(withdrawView)
        }
        noticeView.snp.makeConstraints { make in
            make.right.equalTo(-55)
            make.top.bottom.width.equalTo(withdrawView)
        }
    }
}

class ImgLabVerticalView: UIView {
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        return img
    }()
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        return lab
    }()
    lazy var badgeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.backgroundColor = UIColor.init(hexString: "E94951")
        lab.font = kSystemFont(12)
        lab.layer.cornerRadius = 8
        lab.layer.masksToBounds = true
        lab.isHidden = true
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(lab)
        addSubview(badgeLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(10)
        }
        badgeLab.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(icon.snp.top).offset(7)
            make.centerX.equalTo(icon.snp.right).offset(-3)
        }
    }
}
