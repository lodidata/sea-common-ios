//
//  NoDataView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/17.
//

import UIKit

class NoDataView: UIView {
    lazy var icon: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .center
        img.image = UIImage.init(named: "no_record")
        return img
    }()
    lazy var lab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(14)
        lab.text = "noData".wlLocalized
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
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
        }
        lab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(15)
        }
    }
    
}
