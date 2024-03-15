//
//  ZKVipEquityTableHeader.swift
//  DNYTY
//
//  Created by WL on 2022/6/28
//  
//
    

import UIKit

class ZKVipEquityTableHeader: ZKView {
    
    let levelLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.backgroundColor = UIColor(hexString: "#E0E2E9")
        lab.font = kMediumFont(14)
        lab.numberOfLines = 2
        lab.textAlignment = .center
        lab.text = "vip11".wlLocalized
        return lab
    }()
    
    let depositLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.backgroundColor = UIColor(hexString: "#E0E2E9")
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.text = "vip22".wlLocalized
        return lab
    }()
    
    let loerttyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.backgroundColor = UIColor(hexString: "#E0E2E9")
        lab.font = kMediumFont(14)
        lab.numberOfLines = 2
        lab.textAlignment = .center
        lab.text = "vip23".wlLocalized
        return lab
    }()
    
    let monthlyMoneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.backgroundColor = UIColor(hexString: "#E0E2E9")
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.text = "vip24".wlLocalized
        return lab
    }()
    
    let promoteHandselLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.backgroundColor = UIColor(hexString: "#E0E2E9")
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.text = "vip25".wlLocalized
        return lab
    }()

    override func makeUI() {
        addSubview(levelLab)
        addSubview(depositLab)
        addSubview(loerttyLab)
        addSubview(monthlyMoneyLab)
        addSubview(promoteHandselLab)
        
        levelLab.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(depositLab).offset(-20)
        }
        depositLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(levelLab.snp.right)
        }
        
        loerttyLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(depositLab)
            make.left.equalTo(depositLab.snp.right)
        }
        monthlyMoneyLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(depositLab)
            make.left.equalTo(loerttyLab.snp.right)
        }
        promoteHandselLab.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(depositLab)
            make.left.equalTo(monthlyMoneyLab.snp.right)
            make.right.equalToSuperview()
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line1)
        line1.snp.makeConstraints { make in
            make.left.equalTo(levelLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        let line2 = UIView()
        line2.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line2)
        line2.snp.makeConstraints { make in
            make.left.equalTo(depositLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
       
        let line3 = UIView()
        line3.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line3)
        
        line3.snp.makeConstraints { make in
            make.left.equalTo(loerttyLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        
        let line4 = UIView()
        line4.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line4)
        
        line4.snp.makeConstraints { make in
            make.left.equalTo(monthlyMoneyLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
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
