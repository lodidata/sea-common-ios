//
//  ZKDepositModeCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKDepositModeCell: UITableViewCell {
    
    let icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        lab.text = "recharge5".wlLocalized
        return lab
    }()
    
    let detailLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge5".wlLocalized
        return lab
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        let myContentView = UIView()
        myContentView.backgroundColor = .white
        myContentView.layer.cornerRadius = 10
        myContentView.layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        myContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        myContentView.layer.shadowOpacity = 1

        
        contentView.addSubview(myContentView)
        myContentView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        }
        
        myContentView.addSubview(icon)
        myContentView.addSubview(titleLab)
        myContentView.addSubview(detailLab)
        icon.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(11)
            make.bottom.equalTo(-11)
            make.width.equalTo(icon.snp.height)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.bottom.equalTo(myContentView.snp.centerY).offset(-2)
        }
        
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(myContentView.snp.centerY).offset(2)
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
