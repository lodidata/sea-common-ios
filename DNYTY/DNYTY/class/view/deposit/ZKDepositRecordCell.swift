//
//  ZKDepositRecordCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/20
//  
//
    

import UIKit

class ZKDepositRecordCell: UITableViewCell {
    var disposeBag = DisposeBag()
    let myContentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    let timelab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "2022-06-01 11:23:00"
        return lab
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(16)
        lab.text = "GCash H5"
        return lab
    }()

    let moneyTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge13".wlLocalized
        return lab
    }()
    let moneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(16)
        lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        lab.text = "0.00"
        return lab
    }()
    
    let bottomView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E0E2E9")
        return view
    }()
    
    let numberLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "-"
        return lab
    }()
    
    let copyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(RImage.copy_btn2(), for: .normal)
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return btn
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor(hexString: "#EDEEF3")
        contentView.addSubview(myContentView)
        
        
        myContentView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 7, left: 16, bottom: 7, right: 16))
        }
        
        
        
        myContentView.addSubview(timelab)
        myContentView.addSubview(titleLab)
        myContentView.addSubview(moneyTitleLab)
        myContentView.addSubview(moneyLab)
        myContentView.addSubview(bottomView)
        
        timelab.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(12)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.right.equalTo(timelab)
            make.top.equalTo(timelab.snp.bottom).offset(6)
        }
        
        moneyTitleLab.snp.makeConstraints{ make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
            
        }
        
        moneyLab.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(moneyTitleLab.snp.centerY)
            make.left.equalTo(moneyTitleLab.snp.right)
        }
        
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(moneyTitleLab.snp.bottom).offset(16)
        }
        
        bottomView.addSubview(numberLab)
        bottomView.addSubview(copyBtn)
        
        numberLab.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(9)
            make.bottom.equalTo(-9)
        }
        
        copyBtn.snp.makeConstraints { make in
            make.right.equalTo(-18)
            make.centerY.equalToSuperview()
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
