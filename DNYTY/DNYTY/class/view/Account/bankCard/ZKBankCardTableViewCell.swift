//
//  ZKBankCardTableViewCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/21
//  
//
    

import UIKit

class ZKBankCardTableViewCell: UITableViewCell {
    
    
    let bankTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "card0".wlLocalized
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let nameTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "card1".wlLocalized
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let accountTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "card2".wlLocalized
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let bankLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "AUB"
        lab.font = kMediumFont(12)
        lab.textAlignment = .right
        return lab
    }()
    
    let nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "novo hermosilla flores"
        lab.font = kMediumFont(12)
        lab.textAlignment = .right
        return lab
    }()
    
    let accountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "09063364388"
        lab.font = kMediumFont(12)
        lab.textAlignment = .right
        return lab
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
    
        contentView.addSubview(bankTitleLab)
        contentView.addSubview(nameTitleLab)
        contentView.addSubview(accountTitleLab)
        
        contentView.addSubview(bankLab)
        contentView.addSubview(nameLab)
        contentView.addSubview(accountLab)
        
        bankTitleLab.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(12)
            
        }
        nameTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(bankTitleLab.snp.bottom).offset(10)
        }
        
        accountTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(nameTitleLab.snp.bottom).offset(10)
            make.bottom.equalTo(-12)
        }
        
        bankLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab.snp.right).offset(5)
            make.centerY.equalTo(bankTitleLab)
            make.right.equalTo(-20)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(nameTitleLab)
            make.right.equalTo(-20)
        }
        
        accountLab.snp.makeConstraints { make in
            make.left.equalTo(accountTitleLab.snp.right).offset(5)
            make.centerY.equalTo(accountTitleLab)
            make.right.equalTo(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
