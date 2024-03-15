//
//  ZKHomeLogoHeader.swift
//  DNYTY
//
//  Created by WL on 2022/7/4
//  
//
    

import UIKit

class ZKHomeLogoHeader: UICollectionReusableView {
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        lab.text = "title"
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "#171633")
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#25244A")
        addSubview(line)
        addSubview(titleLab)
        
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.snp.top)
            make.height.equalTo(1)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
