//
//  WLUserActiveListDataModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/15.
//

import UIKit

class WLUserActiveListDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        type_id <- map["type_id"]
        title <- map["title"]
        text <- map["text"]
        link <- map["link"]
        img <- map["img"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        details <- map["details"]
        state <- map["state"]
        template_id <- map["template_id"]
        template_name <- map["template_name"]
        content <- map["content"]
        content_type <- map["content_type"]
        active_type_id <- map["active_type_id"]
        issue_mode <- map["issue_mode"]
        
    }
    
    var id: Int = 0
    var type_id: Int = 0
    var title: String = ""
    var text: String = ""
    var link: String = ""
    var img: String = ""
    var start_time: String = ""
    var end_time: String = ""
    var details: String = ""
    var state: String = "" //状态,有apply就显示,没有就不显示(apply:可申请, auto:自动参与)
    var template_id: String = ""
    var template_name: String = ""
    var content: String = ""
    var content_type: Int = -99
    var active_type_id: Int = -99
    var issue_mode: Int = -99
}

class WLUserActiveTypesDataModel: Mappable {
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        created <- map["created"]
    }
    
    required init?(map: Map) {
        
    }
    
    var id: Int = 0
    var name: String = ""
    var description: String = ""
    var created: String = ""
}

class WLStartConfigDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        spread_url <- map["spread_url"]
        code <- map["code"]
        
        h5_url <- map["h5_url"]
        ios_url <- map["ios_url"]
    }
    
    var spread_url: String?
    var code: String?
  
    var h5_url: String = ""
    var ios_url: String = ""
}
