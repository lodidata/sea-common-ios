//
//  ZKDepositWalletView.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit

class ZKDepositWalletView: ZKView {
    let backgroundView: UIImageView = {
        let imgV = UIImageView(image: RImage.walltet_bg())
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let accountBackgroundView: UIImageView = {
        var image = RImage.walltet_account_bg()
        image = image?.stretchableImage(withLeftCapWidth: Int(image!.size.width)/2, topCapHeight: Int(image!.size.height)/2)
        let imgV = UIImageView(image: image)
        //imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let accountIconView: UIImageView = {
        let imgV = UIImageView(image: RImage.walltet_account())
        imgV.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    let accountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(14)
        lab.text = "       "
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let moneyIconView: UIImageView = {
        let imgV = UIImageView(image: RImage.wallet_money())
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    let moneyTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(14)
        lab.text = "recharge2".wlLocalized
        return lab
    }()
    
    let moneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(24)
        lab.text = "0.00"
        return lab
    }()

    override func makeUI() {
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(accountBackgroundView)
        addSubview(accountIconView)
        addSubview(accountLab)
        
        addSubview(moneyIconView)
        addSubview(moneyTitleLab)
        addSubview(moneyLab)
        
        accountBackgroundView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.right).multipliedBy(10.0/363)
            make.top.equalTo(20)
        }
        
        accountIconView.snp.makeConstraints { make in
            make.left.equalTo(accountBackgroundView).offset(15)
            make.centerY.equalTo(accountBackgroundView.snp.centerY)
        }
        
        accountLab.snp.makeConstraints { make in
            make.left.equalTo(accountIconView.snp.right).offset(5)
            make.centerY.equalTo(accountIconView.snp.centerY)
            make.right.equalTo(accountBackgroundView.snp.right).offset(-5)
        }
        
        moneyTitleLab.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).multipliedBy(343.0/363)
            make.centerY.equalTo(accountIconView.snp.centerY)
        }
        
        moneyIconView.snp.makeConstraints { make in
            make.right.equalTo(moneyTitleLab.snp.left).offset(-5)
            make.centerY.equalTo(moneyTitleLab.snp.centerY)
        }
        
        moneyLab.snp.makeConstraints { make in
            make.right.equalTo(moneyTitleLab.snp.right)
            make.top.equalTo(moneyTitleLab.snp.bottom).offset(5)
        }
    }

}
