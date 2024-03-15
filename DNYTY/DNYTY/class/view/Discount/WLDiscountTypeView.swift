//
//  WLDiscountTypeView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit

class WLDiscountTypeView: UIView {

    typealias CellDidBlock = (_ id: Int) -> Void
    var selectBlock: CellDidBlock?
    lazy var topView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        return aView
    }()
    lazy var lab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "0E0D20")
        lab.font = kSystemFont(12)
        lab.text = "type2Txt1".wlLocalized
        return lab
    }()
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .center
        icon.image = UIImage.init(named: "h_ljt")
        return icon
    }()
    lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        aView.layer.borderColor = UIColor.init(hexString: "7F4FE8")?.cgColor
        aView.layer.borderWidth = 2
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLDiscountTypeCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topView)
        topView.addSubview(lab)
        topView.addSubview(icon)
        addSubview(bgView)
        bgView.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(42)
        }
        lab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var dataList: [WLUserActiveTypesDataModel]? {
        didSet {
            tableView.reloadData()
        }
    }
}

extension WLDiscountTypeView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WLDiscountTypeCell
        let selectBgView = UIView()
        selectBgView.backgroundColor = UIColor.init(hexString: "D6D9E3")
        cell.selectedBackgroundView = selectBgView
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bgView.isHidden = true
        lab.text = dataList?[indexPath.row].name
        if let block = selectBlock, let id = dataList?[indexPath.row].id {
            block(id)
        }
    }
}

class WLDiscountTypeCell: UITableViewCell {
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "0E0D20")
        lab.font = kSystemFont(14)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lab)
//        contentView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    var dataModel: WLUserActiveTypesDataModel? {
        didSet {
            lab.text = dataModel?.name
        }
    }
}
