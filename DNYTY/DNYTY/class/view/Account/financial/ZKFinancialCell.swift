//
//  ZKFinancialCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKFinancialCell: UITableViewCell {
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        
        return lab
    }()
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.fin_enter_r())
        return imgV
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(titleLab)
        contentView.addSubview(icon)
        
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        contentView.addSubview(line)
        
        titleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(26)
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalTo(-26)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(1)
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
