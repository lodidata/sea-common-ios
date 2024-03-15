//
//  WLGameTypeListView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/23.
//

import UIKit


class WLGameTypeListView: UIView {

    typealias CellDidBlock = (_ model: WLUserAgentBettingFiterDataModel) -> Void
    var selectBlock: CellDidBlock?
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLGameTypeCell.self, forCellReuseIdentifier: "cell")
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
        backgroundColor = UIColor.init(hexString: "EDEEF3")
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.init(named: "7F4FE8")?.cgColor
        layer.borderWidth = 1
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var dataList: [WLUserAgentBettingFiterDataModel]? {
        didSet {
            tableView.reloadData()
        }
    }
}

extension WLGameTypeListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WLGameTypeCell
        let selectBgView = UIView()
        selectBgView.backgroundColor = UIColor.init(hexString: "D6D9E3")
        cell.selectedBackgroundView = selectBgView
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //removeFromSuperview()
        if let block = selectBlock, let data = dataList?[indexPath.row] {
            block(data)
        }
    }
}

class WLGameTypeCell: UITableViewCell {
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "0E0D20")
        lab.font = kSystemFont(14)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lab)
        contentView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        //contentView.backgroundColor = .clear
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
    
    var dataModel: WLUserAgentBettingFiterDataModel? {
        didSet {
            lab.text = dataModel?.name
        }
    }
}
