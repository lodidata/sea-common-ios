//
//  WLYesterdayDataView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit
import SwiftDate

class WLYesterdayDataView: UIView {

    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        return dateFormmater
    }()
    lazy var titleView: WLSpreadTitleView = {
        let aView = WLSpreadTitleView()
        aView.titleLab.text = "agency23".wlLocalized
        aView.dateLab.text = formatter.string(from: Date() - 1.days)
        aView.alertLab.text = ""
        return aView
    }()
    lazy var totalWaterView: WLSpreadRealDataItem = {
        let item = WLSpreadRealDataItem()
        item.img.image = UIImage.init(named: "total_water_yellow")
        item.titleLab.text = "agency28".wlLocalized
        item.dataLab.text = "-"
        return item
    }()
    lazy var companyCostView: WLSpreadRealDataItem = {
        let item = WLSpreadRealDataItem()
        item.img.image = UIImage.init(named: "cost_icon")
        item.titleLab.text = "agency61".wlLocalized
        item.dataLab.text = "-"
        return item
    }()
    lazy var totalProfileView: WLSpreadRealDataItem = {
        let item = WLSpreadRealDataItem()
        item.img.image = UIImage.init(named: "yingli_icon")
        item.titleLab.text = "agency29".wlLocalized
        item.dataLab.text = "-"
        return item
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleView)
        addSubview(totalWaterView)
        addSubview(companyCostView)
        addSubview(totalProfileView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(30)
        }
        totalWaterView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(titleView.snp.bottom)
            make.width.equalTo((kScreenWidth-60)/3)
            make.height.equalTo(96)
        }
        companyCostView.snp.makeConstraints { make in
            make.left.equalTo(totalWaterView.snp.right).offset(15)
            make.top.width.height.equalTo(totalWaterView)
        }
        totalProfileView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.width.height.equalTo(totalWaterView)
        }
    }
}
