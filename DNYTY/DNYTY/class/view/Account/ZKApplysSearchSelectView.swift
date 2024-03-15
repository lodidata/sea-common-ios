//
//  ZKApplysSearchSelectView.swift
//  DNYTY
//
//  Created by WL on 2022/7/4
//  
//
    

import UIKit

class ZKApplysSearchSelectView: ZKView {

    let startBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        let date = NSDate()
        btn.titleLab.text = "recharge7".wlLocalized
        btn.textLab.text = date.string(withFormat: "yyyy-MM/-d")
        return btn
    }()
    
    let endBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        btn.titleLab.text = "recharge8".wlLocalized
        let date = NSDate()
        btn.textLab.text = date.string(withFormat: "yyyy-MM-dd")
        return btn
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 343, height: 44))
        bg.cornerRadius = 5
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("finance6".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        return btn
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func makeUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
       
        contentView.addSubview(startBtn)
        contentView.addSubview(endBtn)
        contentView.addSubview(searchBtn)
        
    
        startBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(10)
            make.height.equalTo(54)
        }
        
        endBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn.snp.right).offset(10)
            make.top.equalTo(startBtn)
            make.right.equalTo(-16)
            make.size.equalTo(startBtn)
        }
        
        
        
        searchBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn)
            make.right.equalTo(endBtn)
            make.top.equalTo(startBtn.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        searchBtn.rx.tap.map{ true }.bind(to: self.rx.isHidden).disposed(by: rx.disposeBag)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
