//
//  WLWithdrawRecordCell.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit

class WLWithdrawRecordCell: UITableViewCell {

    private lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    lazy var typeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(16)
        lab.text = "--"
        return lab
    }()
    lazy var lab1: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw17".wlLocalized
        return lab
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(16)
        lab.text = "--"
        return lab
    }()
    private lazy var bottomView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor.init(hexString: "E0E2E9")
        return aView
    }()
    lazy var lab2: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "account20".wlLocalized
        return lab
    }()
    lazy var orderLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    lazy var copyBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "copy_icon"), for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        contentView.addSubview(bgView)
        bgView.addSubview(dateLab)
        bgView.addSubview(typeLab)
        bgView.addSubview(lab1)
        bgView.addSubview(amountLab)
        bgView.addSubview(bottomView)
        bottomView.addSubview(lab2)
        bottomView.addSubview(orderLab)
        bottomView.addSubview(copyBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.bottom.equalToSuperview()
        }
        dateLab.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(12)
        }
        typeLab.snp.makeConstraints { make in
            make.left.equalTo(dateLab)
            make.top.equalTo(dateLab.snp.bottom).offset(10)
        }
        lab1.snp.makeConstraints { make in
            make.left.equalTo(dateLab)
            make.top.equalTo(typeLab.snp.bottom).offset(10)
        }
        amountLab.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(lab1)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        lab2.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        copyBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(40)
        }
        orderLab.snp.makeConstraints { make in
            make.left.equalTo(lab2.snp.right).offset(2)
//            make.right.equalTo(copyBtn.snp.left).offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    var dataModel: WLWalletWithdrawHistoryDataModel? {
        didSet {
            dateLab.text = dataModel?.created
            typeLab.text = dataModel?.receive_bank_info?.bank
            amountLab.text = dataModel?.money?.divide100().stringValue
            orderLab.text = dataModel?.trade_no
        }
    }
}
