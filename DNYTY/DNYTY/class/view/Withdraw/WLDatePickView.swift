//
//  WLDatePickView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/17.
//

import UIKit

class WLDatePickView: UIView {
    

    lazy var toolView: PickTopView = {
        let aView = PickTopView.init()
        aView.backgroundColor = UIColor.white
        return aView
    }()
    lazy var pickView: UIDatePicker = {
        let pickView = UIDatePicker.init()
        pickView.backgroundColor = UIColor.white
        pickView.datePickerMode = .date
        pickView.locale = Locale.init(identifier: "zh_CN")
        if #available(iOS 13.4, *) {
            pickView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                pickView.backgroundColor = UIColor.black
            } else {
                pickView.backgroundColor = UIColor.white
            }
        } else {
            // Fallback on earlier versions
            pickView.backgroundColor = UIColor.white
        }
        return pickView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addSubview(toolView)
        addSubview(pickView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pickView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        toolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickView.snp.top)
            make.height.equalTo(44)
        }
    }
    
}
class PickTopView: UIView {

    lazy var cancelBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("text2".wlLocalized, for: .normal)
        btn.titleLabel?.font = kSystemFont(15)
        btn.setTitleColor(RGB(35, 35, 35), for: .normal)
        return btn
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = RGB(35, 35, 35)
        lab.text = ""
        lab.font = kSystemFont(15)
        return lab
    }()
    lazy var comfirmBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("text4".wlLocalized, for: .normal)
        btn.titleLabel?.font = kSystemFont(15)
        btn.setTitleColor(RGB(35, 35, 35), for: .normal)
        return btn
    }()
    private var line: UIView = {
        let line = UIView.init()
        line.backgroundColor = RGB(234, 234, 234)
        return line
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(cancelBtn)
        addSubview(titleLab)
        addSubview(comfirmBtn)
        addSubview(line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        titleLab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        comfirmBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
}
