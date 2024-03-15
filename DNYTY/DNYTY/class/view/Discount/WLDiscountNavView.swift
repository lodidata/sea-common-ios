//
//  WLDiscountNavView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit

class WLDiscountNavView: UIView {

    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        return img
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(12)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "0E0D20")
        addSubview(icon)
        addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.bottom.equalTo(-15)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.centerY.equalTo(icon)
        }
    }
    
}
class WLDiscountNav2View: UIView {

    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.image = UIImage.init(named: "back_gray")
        return img
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(16)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "0E0D20")
        addSubview(icon)
        addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.centerY.equalToSuperview().offset(5)
            make.width.height.equalTo(40)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(icon)
        }
    }
    
}
