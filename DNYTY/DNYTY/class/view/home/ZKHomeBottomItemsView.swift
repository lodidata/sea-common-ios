//
//  ZKHomeBottomItemsView.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit

class ZKHomeBottomItemsView: UIStackView {
    
    var items: [(UIImage?, String)] = [] {
        didSet {
            self.makeUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        
        removeAllSubviews()
        for (logo, title) in items {
            let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = kSystemFont(12)
            //btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
//            btn.setImage(logo, for: .normal)
//            btn.setTitle(title, for: .normal)

//            btn.set(image: logo, title: title, titlePosition: bottom, additionalSpacing: 10, state: .normal)

            btn.set(image: logo, title: title, titlePosition: .bottom, additionalSpacing: 10, state: .normal)

            addArrangedSubview(btn)
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
