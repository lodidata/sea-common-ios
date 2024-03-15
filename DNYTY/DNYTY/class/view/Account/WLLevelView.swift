//
//  WLLevelView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLLevelView: UIView {

    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kMediumFont(16)
        lab.text = "vip1".wlLocalized
        return lab
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle( "vip2".wlLocalized + " ", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        btn.setImage(UIImage.init(named: "arrow_right_black"), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
    lazy var levelImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        img.image = UIImage.init(named: "vip0")
        return img
    }()
    
    let moneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "vip26".wlLocalized + " >= 0"
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lab)
        addSubview(btn)
        addSubview(levelImg)
        addSubview(moneyLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalToSuperview()
            make.bottom.equalTo(levelImg.snp.top)
            make.centerY.equalTo(lab)
            make.height.equalTo(30)
        }
        levelImg.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(lab.snp.bottom).offset(15)
            make.height.equalTo(160)
        }
        moneyLab.snp.makeConstraints { make in
            make.left.equalTo(levelImg.snp.left).offset(7)
            make.bottom.equalTo(levelImg.snp.bottom).offset(-7)
        }
    }
}

class WLConditionView: UIView {
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "-"
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var currentLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "vip5".wlLocalized
        return lab
    }()
    lazy var current: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "FF9B00")
        lab.font = kSystemFont(14)
        lab.text = "--"
        return lab
    }()
    lazy var need: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "/ --"
        return lab
    }()
    lazy var differ: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "vip6".wlLocalized + "--"
        return lab
    }()
    lazy var progressView: UIProgressView = {
        let aView = UIProgressView()
        aView.progressTintColor = UIColor.init(hexString: "FF9B00")
        aView.trackTintColor = UIColor.init(hexString: "EDEEF3")
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLab)
        addSubview(line)
        addSubview(currentLab)
        addSubview(current)
        addSubview(need)
        addSubview(differ)
        addSubview(progressView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        currentLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(line.snp.bottom).offset(15)
        }
        current.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(currentLab.snp.bottom).offset(5)
        }
        need.snp.makeConstraints { make in
            make.left.equalTo(current.snp.right).offset(3)
            make.centerY.equalTo(current)
        }
        differ.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(current)
        }
        progressView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(current.snp.bottom).offset(6)
            make.height.equalTo(5)
        }
    }
}

class WLAwardKindView: UIView {
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(16)
        lab.text = "vip7".wlLocalized
        return lab
    }()
    lazy var improveView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "improve_icon")
        aView.titleLab.text = "vip8".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    lazy var weekView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "week_award")
        aView.titleLab.text = "vip9".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    lazy var monthView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "month_award")
        aView.titleLab.text = "vip10".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLab)
        addSubview(improveView)
        addSubview(weekView)
        addSubview(monthView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        improveView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.width.equalTo((kScreenWidth - 60) / 3)
            make.bottom.equalToSuperview()
        }
        weekView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.width.bottom.equalTo(improveView)
        }
        monthView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.width.bottom.equalTo(improveView)
        }
    }
}

class WLAwardItemView: UIView {
    
    lazy var img: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .center
        return img
    }()
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 2
        lab.textAlignment = .center
        lab.font = kSystemFont(14)
        return lab
    }()
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "FF9B00")
        lab.font = kSystemFont(16)
        return lab
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "72788B"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "EDEEF3")
        addSubview(img)
        addSubview(bgView)
        bgView.addSubview(titleLab)
        bgView.addSubview(lab)
        bgView.addSubview(btn)
        bringSubviewToFront(img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(30)
            make.bottom.equalToSuperview()
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(10)
            make.right.lessThanOrEqualTo(-10)
            make.top.equalTo(35)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(10)
        }
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        }
    }
}
