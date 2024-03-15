//
//  ZKScrollNoticesView.swift
//  DNYTY
//
//  Created by WL on 2022/6/25
//  
//
    

import UIKit

class ZKScrollNoticesView: ZKView {
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.scroll_notices())
        return imgV
    }()
    
    let scrollLab: LZScrollLabel = {
        let lab = LZScrollLabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 50, height: 30))
        lab.scrollSpeed = 70
        return lab
    }()
    
    var text: String = "" {
        didSet {
            scrollLab.setTitle(text, .white, .left, kMediumFont(12))
            scrollLab.startAnimate()
        }
    }
    
    override func makeUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        addSubview(icon)
        addSubview(scrollLab)
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        scrollLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.right.bottom.equalToSuperview()
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


extension Reactive where Base: ZKScrollNoticesView {
    var text: Binder<String> {
        Binder(base) { view, text in
            view.text = text
        }
    }
}
