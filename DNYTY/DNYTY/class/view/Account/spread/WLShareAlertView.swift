//
//  WLShareAlertView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/29.
//

import UIKit

class WLShareAlertView: UIView {

    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "agency5".wlLocalized
        return lab
    }()
    lazy var whatsappView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.whatsapp_share()
        aView.lab.text = "Whatsapp"
        return aView
    }()
    lazy var telegramView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.telegram_share()
        aView.lab.text = "Telegram"
        return aView
    }()
    lazy var lineView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.line_share()
        aView.lab.text = "Line"
        return aView
    }()
    lazy var viberView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.viber_share()
        aView.lab.text = "Viber"
        return aView
    }()
    lazy var messergerView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.messerger_share()
        aView.lab.text = "Messenger"
        return aView
    }()
    lazy var instagramView: WLItemView = {
        let aView = WLItemView()
        aView.icon.image = RImage.instagram_share()
        aView.lab.text = "Instagram"
        return aView
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.init(hexString: "969CB0"), for: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        btn.setTitle("agency6".wlLocalized, for: .normal)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(titleLab)
        addSubview(whatsappView)
        addSubview(telegramView)
        addSubview(lineView)
        addSubview(viberView)
        addSubview(messergerView)
        addSubview(instagramView)
        addSubview(line)
        addSubview(cancelBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        whatsappView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(70)
            make.width.equalTo(60)
            make.height.equalTo(80)
        }
        telegramView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(whatsappView)
            make.width.height.equalTo(whatsappView)
        }
        lineView.snp.makeConstraints { make in
            make.right.equalTo(-30)
            make.centerY.equalTo(whatsappView)
            make.width.height.equalTo(whatsappView)
        }
        viberView.snp.makeConstraints { make in
            make.left.equalTo(whatsappView)
            make.top.equalTo(whatsappView.snp.bottom).offset(15)
            make.width.height.equalTo(whatsappView)
        }
        messergerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(viberView)
            make.width.height.equalTo(whatsappView)
        }
        instagramView.snp.makeConstraints { make in
            make.right.equalTo(lineView)
            make.centerY.equalTo(viberView)
            make.width.height.equalTo(whatsappView)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(viberView.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-TABBAR_BOTTOM)
            make.top.equalTo(line.snp.bottom)
        }
    }
}

class WLShareAlertAlphaView: UIView {
    
    
    lazy var alertView: WLShareAlertView = {
        let aView = WLShareAlertView()
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black.withAlphaComponent(0.3)
        addSubview(alertView)
        alertView.cancelBtn.rx.tap.bind { [unowned self] _ in
            removeFromSuperview()
        }.disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alertView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(320+TABBAR_BOTTOM)
        }
    }
    
}
