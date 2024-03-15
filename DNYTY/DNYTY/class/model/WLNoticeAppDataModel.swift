//
//  WLNoticeAppDataModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/21
//  
//
    

import UIKit

class WLNoticeAppDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        popup_type <- map["popup_type"]
        title <- map["title"]
        content <- map["content"]
        start_time <- map["start_time"]
        created <- map["created"]
        img <- map["imgs"]
    }
    

    var id: NSNumber?
    var img: String = ""
    var popup_type: NSNumber?
    var title: String?
    var content: String?
    var start_time: String?
    var created: String?
    
    var imgUrl: URL? {
        URL(string: img)
    }
}
