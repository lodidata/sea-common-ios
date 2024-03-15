//
//  WLWithdrawInfoView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit
import YYText

class WLWithdrawInfoView: UIView {

    private lazy var bgImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = UIImage.init(named: "withdraw_bg")
        img.isUserInteractionEnabled = true
        return img
    }()
    
    lazy var nameLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = .white
        lab.font = kSystemFont(14)
        lab.text = "--"
        return lab
    }()
    private lazy var icon: UIImageView = {
        let img = UIImageView.init()
        img.image = UIImage.init(named: "money_icon")
        img.contentMode = .center
        return img
    }()
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.text = "new6".wlLocalized
        lab.font = kSystemFont(14)
        lab.textColor = .white
        return lab
    }()
    lazy var amountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(24)
        lab.text = "--"
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubview(bgImg)
        addSubview(nameLab)
        addSubview(icon)
        addSubview(lab)
        addSubview(amountLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.left.equalTo(50)
        }
        lab.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(20)
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(lab.snp.left).offset(-10)
            make.centerY.equalTo(lab)
        }
        amountLab.snp.makeConstraints { make in
            make.right.equalTo(lab)
            make.top.equalTo(lab.snp.bottom)
        }
    }
}


class WLWithdrawInfo2View: UIView {
    
    var tfd: UITextField!
    private lazy var lab1: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw6".wlLocalized
        return lab
    }()
    private lazy var tfdView: UIView = {
        let aView = UIView()
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        aView.layer.borderColor = UIColor.init(hexString: "E8E9F0")?.cgColor
        aView.layer.borderWidth = 1
        let tfd = UITextField()
        tfd.borderStyle = .none
        tfd.font = kSystemFont(16)
        tfd.textColor = UIColor.init(hexString: "72788B")
        tfd.textAlignment = .right
        tfd.keyboardType = .decimalPad
        aView.addSubview(tfd)
        
        self.tfd = tfd
        return aView
    }()
    lazy var lab2: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "wallet5".wlLocalized
        lab.isHidden = true
        return lab
    }()
    lazy var offlab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "--"
        lab.isHidden = true
        return lab
    }()
    lazy var alertBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "tanhao_red"), for: .normal)
        btn.setTitle("wallet6".wlLocalized, for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "FF354A"), for: .normal)
        btn.isHidden = true
        btn.titleLabel?.font = kSystemFont(12)
        return btn
    }()
    private lazy var line1: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var lab3: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw7".wlLocalized
        return lab
    }()
    lazy var fanweilab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    private lazy var line2: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var lab4: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw13".wlLocalized
        return lab
    }()
    lazy var reallab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "7F4FE8")
        lab.font = kSystemFont(24)
        lab.text = ""
        return lab
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = .white
        addSubview(lab1)
        addSubview(tfdView)
        addSubview(lab2)
        addSubview(offlab)
        addSubview(alertBtn)
        addSubview(line1)
        addSubview(lab3)
        addSubview(fanweilab)
        addSubview(line2)
        addSubview(lab4)
        addSubview(reallab)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(25)
        }
        tfdView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.height.equalTo(44)
        }
        tfd.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        offlab.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(tfd.snp.bottom).offset(12)
        }
        lab2.snp.makeConstraints { make in
            make.right.equalTo(offlab.snp.left)
            make.centerY.equalTo(offlab)
        }
        alertBtn.snp.makeConstraints { make in
            make.right.equalTo(tfd)
            make.top.equalTo(tfd.snp.bottom).offset(10)
        }
        line1.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(lab2.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        lab3.snp.makeConstraints { make in
            make.left.equalTo(lab1)
            make.top.equalTo(line1.snp.bottom).offset(10)
        }
        fanweilab.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(lab3)
        }
        line2.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(lab3.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        lab4.snp.makeConstraints { make in
            make.left.equalTo(lab1)
            make.top.equalTo(line2.snp.bottom).offset(17)
        }
        reallab.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(lab4)
        }
        
    }
}

class WLWithdrawBankInfoView: UIView {
    typealias CellDidSelectBlock = (_ data: WLBankBindListDataModel) -> Void
    var selectBlock: CellDidSelectBlock?
    var selectList = [Int]()
    var dataList: [WLBankBindListDataModel]? {
        didSet {
            selectList.removeAll()
            if let list = dataList {
                for (index, _) in list.enumerated() {
                    if index == 0 {
                        selectList.append(1)
                    } else {
                        selectList.append(0)
                    }
                }
            }
            tableView.reloadData()
        }
    }
    
    lazy var topView: WLWithdrawBankSelectActView = {
        let aView = WLWithdrawBankSelectActView()
        return aView
    }()
    lazy var selectItem: WLWithdrawBankItemView = {
        let item = WLWithdrawBankItemView()
        return item
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WLWithdrawBankListCell.self, forCellReuseIdentifier: "bank")
        tableView.rowHeight = 85
        tableView.isHidden = true
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(topView)
        addSubview(selectItem)
        addSubview(tableView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(45)
        }
        selectItem.snp.makeConstraints { make in
            make.left.right.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(-20)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(topView)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(-20)
        }
    }
    
}

extension WLWithdrawBankInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bank") as! WLWithdrawBankListCell
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
        }
        if indexPath.row < selectList.count {
            if selectList[indexPath.row] == 1 {
                cell.item.bgView.layer.borderColor = UIColor.init(hexString: "7F4FE8")?.cgColor
            } else {
                cell.item.bgView.layer.borderColor = UIColor.init(hexString: "E8E9F0")?.cgColor
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectList[indexPath.row] != 1 {
            selectList.removeAll()
            if let list = dataList {
                for _ in list {
                    selectList.append(0)
                }
            }
            selectList[indexPath.row] = 1
            tableView.reloadData()
            if let block = selectBlock, let data = dataList?[indexPath.row] {
                block(data)
            }
        } else {
            tableView.isHidden = true
            selectItem.isHidden = false
            topView.icon.isSelected = false
        }
    }
}
