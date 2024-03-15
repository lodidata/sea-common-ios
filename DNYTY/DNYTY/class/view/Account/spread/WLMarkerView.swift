//
//  WLMarkerView.swift
//  DNYTY
//
//  Created by wulin on 2022/7/6.
//

import UIKit
import Charts

class WLMarkerView: MarkerView {

    
    
    override class func viewFromXib(in bundle: Bundle = .main) -> MarkerView? {
        return MyMarkerView.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 80))
    }
    
    
    
    
}
