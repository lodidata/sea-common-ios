//
//  ZKVipButton.swift
//  DNYTY
//
//  Created by WL on 2022/6/24
//  
//
    

import UIKit

class ZKVipButton: ZKView {
    
    var isSelected: Bool {
        get {
            showBtn.isSelected
        }
        
        set {
            showBtn.isSelected = newValue
        }
        
    }
    
    let openBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(RImage.vip_open_btn(), for: .normal)
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        btn.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return btn
    }()
    
    let showBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(RImage.vip_show_btn(), for: .normal)
        
        btn.setImage(RImage.vip_hide_btn(), for: .selected)
        return btn
    }()
    
    override func makeUI() {
        addSubview(openBtn)
        addSubview(showBtn)
        
        openBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        showBtn.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(28)
        }
        
        //rx.beginShow.bind(to: rx.isSelected).disposed(by: rx.disposeBag)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension Reactive where Base: ZKVipButton {
    var isSelected: Binder<Bool> {
        Binder(base) { view, isSelected in
            view.isSelected = isSelected
        }
    }
    
    var open: ControlEvent<Void> {
        base.openBtn.rx.tap
    }
    
    var beginShow: Observable<Bool> {
        base.showBtn.rx.tap.map{ !base.isSelected }.do { isSelected in
            base.isSelected = isSelected
        }
    }
}


