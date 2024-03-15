//
//  ZKVipEquityView.swift
//  DNYTY
//
//  Created by WL on 2022/6/28
//  
//
    

import UIKit
import RxSwift

class ZKVipEquityView: ZKView {

    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(16)
        lab.text = "vip2".wlLocalized
        return lab
    }()
    
    lazy var improveView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "improve_icon")
        aView.titleLab.text = "vip8".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    
    lazy var weekView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "week_award")
        aView.titleLab.text = "vip9".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    
    lazy var monthView: WLAwardItemView = {
        let aView = WLAwardItemView()
        aView.img.image = UIImage.init(named: "month_award")
        aView.titleLab.text = "vip10".wlLocalized
        aView.lab.text = "-"
        return aView
    }()
    
    override func makeUI() {
        addSubview(titleLab)
        addSubview(improveView)
        addSubview(weekView)
        addSubview(monthView)
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        improveView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.height.equalTo(improveView.snp.width).multipliedBy(140.0/108)
            make.bottom.equalToSuperview()
        }
        weekView.snp.makeConstraints { make in
            make.left.equalTo(improveView.snp.right).offset(10)
            make.height.width.bottom.equalTo(improveView)
        }
        monthView.snp.makeConstraints { make in
            make.left.equalTo(weekView.snp.right).offset(10)
            make.height.width.bottom.equalTo(improveView)
            make.right.equalTo(-15)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension Reactive where Base: ZKVipEquityView {
    var level: Binder<ZKUserServer.LevelModel> {
        Binder(base) { view, model in
            view.improveView.lab.text = (model.promoteHandsel/100).stringValue
            view.weekView.lab.text = ((Double(model.transferHandsel) ?? 0)/100).stringValue + "%"
            view.monthView.lab.text = (model.monthlyMoney/100).stringValue
        }
    }
}
