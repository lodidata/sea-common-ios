//
//  ZKLoadingView.swift
//  DNYTY
//
//  Created by WL on 2022/6/25
//  
//
    

import UIKit

class ZKLoadingView: ZKView {

    let icon: SDAnimatedImageView = {
        let imgV = SDAnimatedImageView(image: SDAnimatedImage(named: "loading_icon.gif"))
        
        return imgV
    }()
    
    init() {
        super.init(frame: CGRect())
        self.backgroundColor = RGB(0, 0, 0, 0.5)
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            let screenWidth = kScreenWidth < kScreenHeight ? kScreenWidth : kScreenHeight
            let width = screenWidth / 2
            make.size.equalTo(CGSize(width: width, height: width * 180/340))
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
