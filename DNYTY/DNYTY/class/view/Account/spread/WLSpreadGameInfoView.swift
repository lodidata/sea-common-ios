//
//  WLSpreadGameInfoView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit

class WLSpreadGameInfoView: UIView {

    var dataList: [WLWebGameListDataModel]? {
        didSet {
            if dataList?.count ?? 0 == 0 {
                tableView.backgroundView = nullView
            } else {
                tableView.backgroundView = nil
            }
            tableView.reloadData()
        }
    }
    private lazy var titleView: WLSpreadGameInfoTitleView = {
        let aView = WLSpreadGameInfoTitleView.init(frame: .zero)
        aView.nameLab.text = "agency47".wlLocalized
        aView.nameLab.numberOfLines = 0
        aView.flowWaterLab.text = "agency54".wlLocalized
        aView.flowWaterLab.numberOfLines = 0
        aView.stockLab.text = "agency55".wlLocalized
        aView.stockLab.numberOfLines = 0
        aView.costLab.text = "agency62".wlLocalized
        aView.costLab.numberOfLines = 0
        aView.fenhongLab.text = "agency56".wlLocalized
        aView.fenhongLab.numberOfLines = 0
        return aView
    }()

    private lazy var nullView: NoDataView = {
        let aView = NoDataView()
        aView.icon.isHidden = true
        aView.icon.image = RImage.list_enter_white()
        return aView
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLSpreadGameInfoCell.self, forCellReuseIdentifier: "gameInfo")
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.backgroundColor = UIColor.white
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleView)
        addSubview(tableView)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
extension WLSpreadGameInfoView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameInfo") as! WLSpreadGameInfoCell
        cell.selectionStyle = .none
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
        }
        return cell
    }
    
}
class WLSpreadGameInfoCell: UITableViewCell {
    
    lazy var item: WLSpreadGameInfoTitleView = {
        let item = WLSpreadGameInfoTitleView()
        item.backgroundColor = .white
        return item
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(item)
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
    
    var dataModel: WLWebGameListDataModel? {
        didSet {
            item.nameLab.text = dataModel?.game_name
            item.flowWaterLab.text = dataModel?.bet
            item.stockLab.text = dataModel?.proportion
            item.costLab.text = dataModel?.fee
            item.fenhongLab.text = dataModel?.bkge
        }
    }
}

class WLSpreadGameInfoTitleView: UIView {
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        return lab
    }()
    private lazy var line1: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    lazy var flowWaterLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        return lab
    }()
    private lazy var line2: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    lazy var stockLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        return lab
    }()
    private lazy var line3: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    lazy var costLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        return lab
    }()
    private lazy var line4: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    lazy var fenhongLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "E0E2E9")
        addSubview(nameLab)
        nameLab.addSubview(line1)
        addSubview(flowWaterLab)
        flowWaterLab.addSubview(line2)
        addSubview(stockLab)
        stockLab.addSubview(line3)
        addSubview(costLab)
        costLab.addSubview(line4)
        addSubview(fenhongLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLab.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo((kScreenWidth-30)/5)
        }
        line1.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        flowWaterLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(nameLab)
        }
        line2.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        stockLab.snp.makeConstraints { make in
            make.left.equalTo(flowWaterLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(nameLab)
        }
        line3.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        costLab.snp.makeConstraints { make in
            make.left.equalTo(stockLab.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(nameLab)
        }
        line4.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(1)
        }
        fenhongLab.snp.makeConstraints { make in
//            make.left.equalTo(stockLab.snp.right)
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(nameLab)
        }
    }
}
