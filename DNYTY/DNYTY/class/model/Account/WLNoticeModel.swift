//
//  WLNoticeModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/22.
//

import UIKit


struct NoticeModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        time <- map["created"]
    }
    
    var id: Int = 0
    var title: String = ""
    var content: String = ""
    var time: String = ""
}

struct BenefitInfoModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        start_time <- map["start_time"]
        status <- map["status"]
        type <- map["type"]
        send_type <- map["send_type"]
    }
    
    var id: Int = 0
    var status: Int = 0
    var type: Int = 0
    var send_type: Int = 0
    var title: String = ""
    var content: String = ""
    var start_time: String = ""
}

class WLUserAgentBettingFiterDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        pid <- map["pid"]
        type <- map["type"]
        name <- map["name"]
        category <- map["category"]
        filter <- map["filter"]
        
    }
    
    var id: NSNumber?
    var pid: NSNumber?
    var type: String?
    var name: String?
    var category: String?
    var filter: [WLFiterDataModel]? = []
    
}
class WLFiterDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        key <- map["key"]
        name <- map["name"]
        
    }
    
    var key: String?
    var name: String?
    
    
}

class WLGameRecordDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        order_number <- map["order_number"]
        game_name <- map["game_name"]
        sub_game_name <- map["sub_game_name"]
        pay_money <- map["pay_money"]
        state <- map["state"]
        mode <- map["mode"]
        create_time <- map["create_time"]
        profit <- map["profit"]
    }
    
    var id: NSNumber = 0
    var order_number: String?
    var game_name: String?
    var sub_game_name: String?
    var pay_money: NSNumber = 0
    var state: String?
    var mode: String?
    var create_time: String = ""
    var profit: NSNumber = 0
    
}

