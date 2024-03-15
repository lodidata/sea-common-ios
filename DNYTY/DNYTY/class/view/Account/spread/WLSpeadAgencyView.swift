//
//  WLSpeadAgencyView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit

class WLSpeadAgencyView: UIView {

    lazy var iconView: WLVertialBtnLabView = {
        let aView = WLVertialBtnLabView()
        aView.btn.setImage(RImage.agency_icon1(), for: .normal)
        aView.lab.text = "agency50".wlLocalized
        return aView
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E3E4EC")
        return line
    }()
    lazy var totalView: WLVertialBtnLabView = {
        let aView = WLVertialBtnLabView()
        aView.btn.setTitle("-", for: .normal)
        aView.lab.text = "agency51".wlLocalized
        return aView
    }()
    lazy var directlyUnderView: WLVertialBtnLabView = {
        let aView = WLVertialBtnLabView()
        aView.btn.setTitle("-", for: .normal)
        aView.lab.text = "agency10".wlLocalized
        return aView
    }()
    lazy var underlineView: WLVertialBtnLabView = {
        let aView = WLVertialBtnLabView()
        aView.btn.setTitle("-", for: .normal)
        aView.lab.text = "agency11".wlLocalized
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
        addSubview(iconView)
        iconView.addSubview(line)
        addSubview(totalView)
        addSubview(directlyUnderView)
        addSubview(underlineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo((self.width)/4)
        }
        line.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        totalView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right)
            make.top.bottom.width.equalTo(iconView)
        }
        directlyUnderView.snp.makeConstraints { make in
            make.left.equalTo(totalView.snp.right)
            make.top.bottom.width.equalTo(iconView)
        }
        underlineView.snp.makeConstraints { make in
            make.left.equalTo(directlyUnderView.snp.right)
            make.top.bottom.width.equalTo(iconView)
        }
    }
}


class WLVertialBtnLabView: UIView {
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.titleLabel?.font = kMediumFont(20)
        return btn
    }()
    
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(14)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
class WLVertialBtnLab2View: UIView {
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.titleLabel?.font = kMediumFont(20)
        return btn
    }()
    
    lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(14)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(btn)
        addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        lab.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
    }
}
