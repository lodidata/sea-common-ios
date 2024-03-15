//
//  WLTurnTableNeedModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit
import ObjectMapper


class WLActiveLuckyPostDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        award_id <- map["award_id"]
        award_name <- map["award_name"]
        award_type <- map["award_type"]
        img <- map["img"]
        award_money <- map["award_money"]
        user_list <- map["user_list"]
        withdraw_val <- map["withdraw_val"]
        award_code <- map["award_code"]
    }
    
    var award_id: NSNumber?
    var award_name: String?
    var award_type: NSNumber?
    var img: String?
    var award_money: NSNumber?
    var user_list: [WLActiveLuckyPostUserListDataModel]?
    var withdraw_val: NSNumber?
    var award_code: String?
}
class WLActiveLuckyPostUserListDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        times <- map["times"]
        
    }
    
    var name: String?
    var id: String?
    var times: String?
    
    
}
class WLActiveLuckyDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        winHistory <- map["winHistory"]
        rule <- map["rule"]
        luckyCount <- map["luckyCount"]
        luckySetting <- map["luckySetting"]
    }
    

    var winHistory: [WLActiveLuckyWinHistoryDataModel]?
    var rule: [WLActiveLuckyRuleDataModel]?
    
    var luckyCount: NSNumber?
    var luckySetting: WLActiveLuckyLuckySettingDataModel?
    
    
}
class WLActiveLuckyWinHistoryDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        coupon_money <- map["coupon_money"]
        money <- map["money"]
        date <- map["date"]
        user_name <- map["user_name"]
    }
    
    var user: String?
    var coupon_money: NSNumber?
    var money: NSNumber?
    var date: String?
    var user_name: String?
    
}
class WLActiveLuckyRuleDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        award_money <- map["award_money"]
        award_name <- map["award_name"]
        award_type <- map["award_type"]
        img <- map["img"]
        award_id <- map["award_id"]
    }
    
    var award_money: NSNumber?
    var award_name: String?
    var award_type: NSNumber?
    var img: String?
    var award_id: NSNumber?
    
}
class WLActiveLuckyLuckySettingDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        end_time <- map["end_time"]
        content <- map["content"]
        status <- map["status"]
        id <- map["id"]
        cover <- map["cover"]
        description <- map["description"]
        name <- map["name"]
    }
    
    var end_time: String?
    var content: String?
    var status: String?
    var id: NSNumber?
    var cover: String?
    var description: String?
    var name: String?
    
}

