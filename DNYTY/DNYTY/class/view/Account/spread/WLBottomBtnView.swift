//
//  WLBottomBtnView.swift
//  DNYTY
//
//  Created by wulin on 2022/7/7.
//

import UIKit

class WLBottomBtnView: UIView {

    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("agency33".wlLocalized, for: .normal)
        btn.setImage(RImage.list_show_d(), for: .normal)
        btn.setTitle("agency34".wlLocalized, for: .selected)
        btn.setImage(RImage.list_show_s(), for: .selected)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.setTitleColor(UIColor.init(hexString: "969CB0"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "EDEEF3")
        addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
    }
}
