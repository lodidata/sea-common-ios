//
//  ZKNullDataView.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKNullDataView: ZKView {

    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.null_data_icon())
        
        return imgV
    }()
    
    let textLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(14)
        lab.text = "noData".wlLocalized

        return lab
    }()
    
    override func makeUI() {
        addSubview(icon)
        addSubview(textLab)
        
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        textLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(13)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
