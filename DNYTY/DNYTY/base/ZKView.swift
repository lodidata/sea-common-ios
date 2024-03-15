//
//  ZKBaseView.swift
//  ZKBaseSwiftProject
//
//  Created by WL on 2021/12/13.
//  Copyright © 2021 zk. All rights reserved.
//

import UIKit
import RxSwift
protocol ZKViewType {
    func makeUI()
    func bindViewModel()
}

class ZKView: UIView, ZKViewType {
    
    
    func makeUI() {
        
    }
    
    func bindViewModel() {
        
    }
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
        bindViewModel()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
