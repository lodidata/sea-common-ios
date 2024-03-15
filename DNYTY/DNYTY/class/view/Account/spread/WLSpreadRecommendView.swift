//
//  WLSpreadRecommendView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit

class WLSpreadRecommendView: UIView {

    private lazy var bgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.image = RImage.recommend_bg()
        return img
    }()

    
    private lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "agency48".wlLocalized
        return lab
    }()
    lazy var recommendLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "-"
        return lab
    }()
    lazy var copyIcon: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.copy_icon(), for: .normal)
        return btn
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E3E4EC")
        return line
    }()
    lazy var copyLinkView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.link_copy()
        aView.lab.text = "agency57".wlLocalized
        return aView
    }()
    lazy var shareView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.share_big()
        aView.lab.text = "agency49".wlLocalized
        return aView
    }()
    lazy var ruleIntroView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.rule_introduce()
        aView.lab.text = "agency1".wlLocalized
        return aView
    }()
    lazy var lookVideoView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.look_video()
        aView.lab.text = "agency40".wlLocalized
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImg)
        addSubview(nameLab)
        addSubview(recommendLab)
        addSubview(copyIcon)
        addSubview(line)
        addSubview(copyLinkView)
        addSubview(shareView)
        addSubview(ruleIntroView)
        addSubview(lookVideoView)
        
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
            make.left.equalTo(17)
            make.top.equalTo(23)
        }
        recommendLab.snp.makeConstraints { make in
            make.right.equalTo(-50)
            make.centerY.equalTo(nameLab)
        }
        copyIcon.snp.makeConstraints { make in
            make.right.equalTo(-17)
            make.centerY.equalTo(recommendLab)
            make.width.lessThanOrEqualTo(18)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(17)
            make.right.equalTo(-17)
            make.top.equalTo(60)
            make.height.equalTo(1)
        }
        copyLinkView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(line.snp.bottom).offset(20)
            make.width.equalTo((self.width-5*15)/4)
            make.bottom.equalToSuperview()
        }
        shareView.snp.makeConstraints { make in
            make.left.equalTo(copyLinkView.snp.right).offset(15)
            make.top.width.bottom.equalTo(copyLinkView)
        }
        ruleIntroView.snp.makeConstraints { make in
            make.left.equalTo(shareView.snp.right).offset(15)
            make.top.width.bottom.equalTo(copyLinkView)
        }
        lookVideoView.snp.makeConstraints { make in
            make.left.equalTo(ruleIntroView.snp.right).offset(15)
            make.top.width.bottom.equalTo(copyLinkView)
        }
    }
}

class WLItemView: UIView {
    
    lazy var icon: UIImageView = {
        let icon = UIImageView.init()
        icon.contentMode = .center
        return icon
    }()
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.centerX.equalToSuperview()
        }
        lab.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
