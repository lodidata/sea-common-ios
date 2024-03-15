//
//  ZKVipEquityTableCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/28
//  
//
    

import UIKit

class ZKVipEquityTableCell: UITableViewCell {

    let levelLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#FF9B00")
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.text = "vip11".wlLocalized
        return lab
    }()
    
    let depositLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.text = "vip22".wlLocalized
        return lab
    }()
    
    let loerttyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
       
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.text = "vip23".wlLocalized
        return lab
    }()
    
    let monthlyMoneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
       
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.text = "vip24".wlLocalized
        return lab
    }()
    
    let promoteHandselLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
       
        lab.font = kMediumFont(14)
        lab.textAlignment = .center
        lab.text = "vip25".wlLocalized
        return lab
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
