//
//  WLPickerView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/17.
//

import UIKit

class WLPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var dataList: [String]? = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList?[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    

    lazy var toolView: PickTopView = {
        let aView = PickTopView.init()
        aView.backgroundColor = UIColor.white
        return aView
    }()
    lazy var pickView: UIPickerView = {
        let pickView = UIPickerView.init()
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
        pickView.dataSource = self
        pickView.delegate = self
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
            make.height.equalTo(180+TABBAR_BOTTOM)
        }
        toolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickView.snp.top)
            make.height.equalTo(44)
        }
    }
    
}
