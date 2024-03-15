//
//  WLBaseModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/15.
//

import UIKit
import ObjectMapper

class WLBaseModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        state <- map["state"]
    }
    
    var message: String = ""
    var state: Int = -99
}
