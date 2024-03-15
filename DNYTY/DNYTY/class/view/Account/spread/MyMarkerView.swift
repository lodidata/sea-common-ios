//
//  MyMarkerView.swift
//  DNYTY
//
//  Created by wulin on 2022/7/6.
//

import UIKit
import Charts

class MyMarkerView: MarkerView {

    lazy var waterColor: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor.init(hexString: "8849F1")
        return aView
    }()
    lazy var profitsColor: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor.init(hexString: "FF9B00")
        return aView
    }()
    
    lazy var waterTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "agency28".wlLocalized
        return lab
    }()
    lazy var waterLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "-"
        return lab
    }()
    lazy var profitsTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "agency29".wlLocalized
        return lab
    }()
    lazy var profitsLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "-"
        return lab
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(waterColor)
        addSubview(waterTitleLab)
        addSubview(waterLab)
        addSubview(profitsColor)
        addSubview(profitsTitleLab)
        addSubview(profitsLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        waterColor.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(6)
            make.height.equalTo(20)
        }
        waterTitleLab.snp.makeConstraints { make in
            make.left.equalTo(waterColor.snp.right).offset(5)
            make.centerY.equalTo(waterColor)
        }
        waterLab.snp.makeConstraints { make in
            make.left.equalTo(waterTitleLab.snp.right)
            make.centerY.equalTo(waterTitleLab)
        }
        profitsColor.snp.makeConstraints { make in
            make.top.equalTo(waterColor.snp.bottom).offset(7)
            make.left.equalTo(waterColor)
            make.width.height.equalTo(waterColor)
        }
        profitsTitleLab.snp.makeConstraints { make in
            make.left.equalTo(waterTitleLab)
            make.centerY.equalTo(profitsColor)
        }
        profitsLab.snp.makeConstraints { make in
            make.left.equalTo(profitsTitleLab.snp.right)
            make.centerY.equalTo(profitsTitleLab)
        }
    }

}
