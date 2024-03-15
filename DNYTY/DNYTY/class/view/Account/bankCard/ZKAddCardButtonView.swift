//
//  ZKAddCardButtonView.swift
//  DNYTY
//
//  Created by WL on 2022/6/22
//  
//
    

import UIKit

class ZKAddCardButtonView: ZKView {

    let backgroundView: UIImageView = {
        var image = RImage.stroke_line()
//        if let size = image?.size {
//            image = image?.stretchableImage(withLeftCapWidth: Int(size.width/2), topCapHeight: Int(size.height)/2)
//        }
        let imgV = UIImageView(image:image)
        
        return imgV
    }()
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.add_icon())
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kSystemFont(14)
        lab.text = "card3".wlLocalized
        return lab
    }()
    
    override func makeUI() {
        addSubview(backgroundView)
        addSubview(icon)
        addSubview(titleLab)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 15, left: 2, bottom: 15, right: 2))
        }
        
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-5)
        }
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(5)
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
