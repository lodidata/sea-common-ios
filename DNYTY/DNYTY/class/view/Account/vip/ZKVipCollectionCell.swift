//
//  ZKVipCollectionCell.swift
//  DNYTY
//
//  Created by WL on 2022/7/4
//  
//
    

import UIKit
import FSPagerView

class ZKVipCollectionCell: FSPagerViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        return imgV
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
        contentView.addSubview(icon)
        contentView.addSubview(moneyLab)
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        moneyLab.snp.makeConstraints { make in
            make.left.equalTo(7)
            make.bottom.equalTo(-7)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
