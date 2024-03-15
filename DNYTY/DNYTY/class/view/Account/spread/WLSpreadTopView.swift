//
//  WLSpreadTopView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit

class WLSpreadTopView: UIView {

    private lazy var bgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.image = RImage.head_spread_bg()
        return img
    }()
    private lazy var nameBgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .center
        img.image = RImage.account_bg_icon()
        return img
    }()
    private lazy var nameIcon: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .center
        img.image = RImage.walltet_account()
        return img
    }()
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(14)
        return lab
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.guanbi_bai(), for: .normal)
        return btn
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(30)
        lab.text = "-"
        return lab
    }()
    private lazy var yueLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(14)
        lab.text = "agency7".wlLocalized
        return lab
    }()

    lazy var walletBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("agency8".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.set(image: RImage.list_enter_white(), title: "agency8".wlLocalized, titlePosition: .left, additionalSpacing: -5, state: .normal)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 20)
        btn.setBackgroundImage(RImage.wallet_bg_icon(), for: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        return btn
    }()
    
    lazy var recommendView: WLSpreadRecommendView = {
        let aView = WLSpreadRecommendView()
        //aView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        aView.layer.borderColor = UIColor.init(hexString: "FFFFFF")?.cgColor
        aView.layer.borderWidth = 1
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImg)
        addSubview(nameBgImg)
        addSubview(nameIcon)
        addSubview(nameLab)
        addSubview(closeBtn)
        addSubview(amountLab)
        addSubview(yueLab)
        addSubview(walletBtn)
        addSubview(recommendView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(270)
        }
        nameBgImg.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(30)
        }
        nameIcon.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(nameBgImg)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(nameIcon.snp.right).offset(5)
            make.centerY.equalTo(nameIcon)
        }
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(25)
        }
        amountLab.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(85)
        }
        yueLab.snp.makeConstraints { make in
            make.left.equalTo(amountLab)
            make.top.equalTo(amountLab.snp.bottom).offset(3)
        }
        walletBtn.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.bottom.equalTo(yueLab.snp.bottom).offset(-10)
        }
        recommendView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(152)
            make.height.equalTo(192)
        }
    }
}
