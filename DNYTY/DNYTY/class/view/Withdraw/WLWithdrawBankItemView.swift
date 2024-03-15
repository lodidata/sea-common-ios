//
//  WLWithdrawBankItemView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/25.
//

import UIKit

class WLWithdrawBankItemView: UIView {

    lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        aView.layer.cornerRadius = 2
        aView.layer.masksToBounds = true
        return aView
    }()
    private lazy var bankTitle: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "Bank:"
        return lab
    }()
    lazy var bank: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = ""
        return lab
    }()
    private lazy var accountNameTitle: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "Account holder:"
        return lab
    }()
    lazy var accountName: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = ""
        return lab
    }()
    private lazy var accountTitle: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "Account no.:"
        return lab
    }()
    lazy var account: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = ""
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(bgView)
        bgView.addSubview(bankTitle)
        bgView.addSubview(bank)
        bgView.addSubview(accountNameTitle)
        bgView.addSubview(accountName)
        bgView.addSubview(accountTitle)
        bgView.addSubview(account)
        
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
            make.bottom.equalTo(0)
        }
        bankTitle.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.equalTo(12)
        }
        bank.snp.makeConstraints { make in
            make.left.equalTo(120)
            make.centerY.equalTo(bankTitle)
        }
        accountNameTitle.snp.makeConstraints { make in
            make.left.equalTo(bankTitle)
            make.top.equalTo(bankTitle.snp.bottom).offset(3)
        }
        accountName.snp.makeConstraints { make in
            make.left.equalTo(bank)
            make.centerY.equalTo(accountNameTitle)
        }
        accountTitle.snp.makeConstraints { make in
            make.left.equalTo(bankTitle)
            make.top.equalTo(accountNameTitle.snp.bottom).offset(3)
        }
        account.snp.makeConstraints { make in
            make.left.equalTo(bank)
            make.centerY.equalTo(accountTitle)
        }
    }

}
class WLWithdrawBankSelectActView: UIView {
    lazy var lab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = "please select bank card"
        return lab
    }()
    lazy var icon: UIButton = {
        let icon = UIButton.init(type: .custom)
        icon.setImage(UIImage.init(named: "list_show_d"), for: .normal)
        icon.setImage(UIImage.init(named: "list_show_s"), for: .selected)
        return icon
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(lab)
        addSubview(icon)
        addSubview(line)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
}

class WLWithdrawBankListCell: UITableViewCell {
    
    lazy var item: WLWithdrawBankItemView = {
        let item = WLWithdrawBankItemView()
        item.bgView.layer.cornerRadius = 5
        item.bgView.layer.masksToBounds = true
        item.bgView.layer.borderColor = UIColor.init(hexString: "E8E9F0")?.cgColor
        item.bgView.layer.borderWidth = 1
        item.backgroundColor = .white
        item.bgView.backgroundColor = .white
        return item
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(item)
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        item.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var dataModel: WLBankBindListDataModel? {
        didSet {
            item.bank.text = dataModel?.bank_name
            item.accountName.text = dataModel?.name
            item.account.text = dataModel?.account
        }
    }
}
