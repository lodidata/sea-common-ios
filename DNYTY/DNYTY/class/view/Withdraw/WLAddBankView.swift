//
//  WLAddBankView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/17.
//

import UIKit

class WLAddBankView: UIView {

    private lazy var lineImg: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage.init(named: "stroke_line")
        icon.contentMode = .scaleToFill
        return icon
    }()
    private lazy var addIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .center
        icon.image = UIImage.init(named: "add_icon")
        return icon
    }()
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.text = "card3".wlLocalized
        lab.font = kSystemFont(14)
        lab.textColor = UIColor.init(hexString: "30333A")
        return lab
    }()
    private lazy var alertlab: UILabel = {
        let lab = UILabel()
        lab.text = "card4".wlLocalized
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lineImg)
        addSubview(addIcon)
        addSubview(lab)
        addSubview(alertlab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(30)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addIcon.snp.bottom).offset(10)
        }
        alertlab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lab.snp.bottom).offset(10)
        }
    }
}
