//
//  ZKHomeLanguageButton.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit

class ZKHomeLanguageButton: ZKView {
    
    let logo: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = .black
        imgV.layer.cornerRadius = 15
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(14)
        lab.text = "   "
        return lab
    }()
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.h_ljt())
        return imgV
    }()

    override func makeUI() {
        backgroundColor = .clear
        layer.borderColor = UIColor(hexString: "#72788B")?.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        addSubview(logo)
        addSubview(titleLab)
        addSubview(icon)
        
        logo.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
        }
    }

}
