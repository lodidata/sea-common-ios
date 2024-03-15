//
//  ZKDepositHeaderView.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit

class ZKDepositHeaderView: ZKView {

    let titleBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setTitle("GCASH H5", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#7753E0"), for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hexString: "#7F4FE8")?.cgColor
        btn.layer.cornerRadius = 6
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 41, bottom: 12, right: 41)
        return btn
    }()
    
    let textLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge15".wlLocalized
        return lab
    }()
    
    override func makeUI() {
        addSubview(titleBtn)
        addSubview(textLab)
        
        titleBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(10).offset(10)
        }
        
        textLab.snp.makeConstraints { make in
            make.left.equalTo(titleBtn)
            //make.top.equalTo(titleBtn.snp.bottom).offset(17)
            make.bottom.equalTo(0)
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
