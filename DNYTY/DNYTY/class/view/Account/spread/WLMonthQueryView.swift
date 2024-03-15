//
//  WLMonthQueryView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit

class WLMonthQueryView: UIView {

    var dataList: [WLSpreadMonthQueryDataModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy"
        return dateFormmater
    }()
    lazy var dateBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        let year = formatter.string(from: Date())
        btn.setTitle(year, for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.set(image: RImage.arrow_down_tri(), title: year, titlePosition: .left, additionalSpacing: 5, state: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        btn.layer.cornerRadius = 16
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.init(hexString: "DDDEE8")?.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "agency30".wlLocalized
        return lab
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLMonthQueryCell.self, forCellReuseIdentifier: "monthQuery")
        tableView.showsVerticalScrollIndicator = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.layer.cornerRadius = 5
        tableView.layer.masksToBounds = true
        tableView.rowHeight = 60
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateBtn)
        addSubview(titleLab)
        addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(32)
            make.width.equalTo(82)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(90)
            make.centerY.equalTo(dateBtn)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(47)
            make.bottom.equalToSuperview()
        }
    }
    
}
extension WLMonthQueryView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthQuery") as! WLMonthQueryCell
        cell.selectionStyle = .none
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
        }
        return cell
    }
    
}

class WLMonthQueryCell: UITableViewCell {
    
    private lazy var monthLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(14)
        lab.text = "-"
        return lab
    }()
    private lazy var totalWater: WLVertialBtnLab2View = {
        let aView = WLVertialBtnLab2View()
        aView.btn.setTitle("-", for: .normal)
        aView.btn.titleLabel?.font = kSystemFont(14)
        aView.lab.font = kSystemFont(12)
        aView.lab.text = "agency28".wlLocalized
        return aView
    }()
    private lazy var stockView: WLVertialBtnLab2View = {
        let aView = WLVertialBtnLab2View()
        aView.btn.setTitle("-", for: .normal)
        aView.btn.titleLabel?.font = kSystemFont(14)
        aView.lab.font = kSystemFont(12)
        aView.lab.text = "agency55".wlLocalized
        return aView
    }()
    private lazy var costView: WLVertialBtnLab2View = {
        let aView = WLVertialBtnLab2View()
        aView.btn.setTitle("-", for: .normal)
        aView.btn.titleLabel?.font = kSystemFont(14)
        aView.lab.font = kSystemFont(12)
        aView.lab.text = "agency61".wlLocalized
        return aView
    }()
    private lazy var totalFenhong: WLVertialBtnLab2View = {
        let aView = WLVertialBtnLab2View()
        aView.btn.setTitle("-", for: .normal)
        aView.btn.titleLabel?.font = kSystemFont(14)
        aView.lab.font = kSystemFont(12)
        aView.lab.text = "agency29".wlLocalized
        return aView
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(monthLab)
        contentView.addSubview(totalWater)
        contentView.addSubview(stockView)
        contentView.addSubview(costView)
        contentView.addSubview(totalFenhong)
        contentView.addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        monthLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        totalWater.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(65)
            make.width.equalTo((kScreenWidth-30-65)/4)
        }
        stockView.snp.makeConstraints { make in
            make.left.equalTo(totalWater.snp.right)
            make.top.bottom.width.equalTo(totalWater)
        }
        costView.snp.makeConstraints { make in
            make.left.equalTo(stockView.snp.right)
            make.top.bottom.width.equalTo(totalWater)
        }
        totalFenhong.snp.makeConstraints { make in
            make.left.equalTo(costView.snp.right)
            make.top.bottom.width.equalTo(totalWater)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    var dataModel: WLSpreadMonthQueryDataModel? {
        didSet {
            if let time = dataModel?.time {
                monthLab.text = String(time.dropFirst(5).prefix(2)) + "new23".wlLocalized
            }
            totalWater.btn.setTitle(dataModel?.bet_amount, for: .normal)
            stockView.btn.setTitle(dataModel?.proportion, for: .normal)
            costView.btn.setTitle(dataModel?.fee, for: .normal)
            //diff 2:红色向下箭头，1:绿色向上箭头，0:不显示
            if let diff = dataModel?.diff.doubleValue {
                if diff == 2 {
                    totalFenhong.btn.set(image: RImage.down_icon_red(), title: dataModel?.bkge ?? "", titlePosition: .left, additionalSpacing: 5, state: .normal)
                } else if diff == 1 {
                    totalFenhong.btn.set(image: RImage.up_icon(), title: dataModel?.bkge ?? "", titlePosition: .left, additionalSpacing: 5, state: .normal)
                } else {
                    totalFenhong.btn.set(image: nil, title: dataModel?.bkge ?? "", titlePosition: .left, additionalSpacing: 5, state: .normal)
                }
            } else {
                totalFenhong.btn.set(image: nil, title: dataModel?.bkge ?? "", titlePosition: .left, additionalSpacing: 5, state: .normal)
            }
        }
    }
}
