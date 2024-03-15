//
//  WLOtherCostView.swift
//  DNYTY
//
//  Created by wulin on 2022/7/6.
//

import UIKit

class WLOtherCostView: UIView {

    private lazy var aline: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var otherTitleLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(13)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.textAlignment = .center
        lab.text = "new2".wlLocalized
        return lab
    }()
    
    lazy var otherLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(13)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.text = "-"
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var alertLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(13)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 0
        lab.text = "new1".wlLocalized
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(aline)
        addSubview(otherTitleLab)
        addSubview(otherLab)
        addSubview(line)
        addSubview(alertLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aline.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        otherTitleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-10)
            make.left.equalToSuperview()
            make.width.equalTo((kScreenWidth-30)/5)
        }
        otherLab.snp.makeConstraints { make in
            make.top.equalTo(otherTitleLab.snp.bottom).offset(5)
            make.centerX.equalTo(otherTitleLab)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(otherTitleLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(line.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
}
