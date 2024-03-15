//
//  WLSpreadDataModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit

class WLSpreadRealDataModel {
    var imageName: String = ""
    var data: String = ""
    var title: String = ""
    
    init(imageName: String, data: String, title: String) {
        self.imageName = imageName
        self.data = data
        self.title = title
    }
}

class WLSpreadMonthQueryDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        bet_amount <- map["bet_amount"]
        bkge <- map["bkge"]
        diff <- map["diff"]
        proportion <- map["proportion"]
        time <- map["time"]
        fee <- map["fee"]
    }
    
    var bet_amount: String = "0"
    var bkge: String = "0"
    var diff: NSNumber = 0
    var proportion: String = ""
    var time: String = ""
    var fee: String = "0"
    
}

class WLAgentMarketDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        marker_link <- map["marker_link"]
        rake_back <- map["rake_back"]
        
        
    }
    
    var marker_link: WLMarkerLinkDataModel?
    var rake_back: [WLRakeBackDataModel]? = []
    
    
}
class WLMarkerLinkDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        all_agent <- map["all_agent"]
        next_agent <- map["next_agent"]
        
        
    }
    
    var code: String = ""
    var all_agent: NSNumber = 0
    var next_agent: NSNumber = 0
    
    
}
class WLRakeBackDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        key_desc <- map["key_desc"]
        key <- map["key"]
        value <- map["value"]
        desc <- map["desc"]
        
    }
    
    var key_desc: String = ""
    var key: String = ""
    var value: NSNumber = 0
    var desc: NSNumber = 0
    
}

class WLUserVideoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        create_time <- map["create_time"]
        link <- map["link"]
        id <- map["id"]
        status <- map["status"]
        location <- map["location"]
        title <- map["title"]
        
    }
    
    var create_time: String = ""
    var link: String = ""
    var id: NSNumber = 0
    var status: NSNumber = 0
    var location: String = ""
    var title: String = ""
    
}

class WLUserAgentRptWebDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        agent_info <- map["agent_info"]
        day_bet_list <- map["day_bet_list"]
        month_bet_list <- map["month_bet_list"]
        today_info <- map["today_info"]
        yesterday_info <- map["yesterday_info"]
        
    }
    
    var agent_info: WLRptWebAgentInfoDataModel?
    var day_bet_list: [WLRptWebDayBetListDataModel]? = []
    var month_bet_list: [WLSpreadMonthQueryDataModel]? = []
    var today_info: WLRptWebTodayInfoDataModel?
    var yesterday_info: WLRptWebYesterdayInfoDataModel?
    
}
class WLRptWebAgentInfoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        all_agent <- map["all_agent"]
        direct_agent <- map["direct_agent"]
        next_agent <- map["next_agent"]
    }
    var all_agent: NSNumber = 0
    var direct_agent: NSNumber = 0
    var next_agent: NSNumber = 0
}
class WLRptWebDayBetListDataModel: Mappable {
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        bet_amount <- map["bet_amount"]
        bkge <- map["bkge"]
        time <- map["time"]
    }
    var bet_amount: String = "0"
    var bkge: String = "0"
    var time: String = ""
}
class WLRptWebTodayInfoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        bet_amount <- map["bet_amount"]
        new_register <- map["new_register"]
        next_agent <- map["next_agent"]
        profits <- map["profits"]
        recharge_amount <- map["recharge_amount"]
        next_bet_amount <- map["next_bet_amount"]
        recharge_user <- map["recharge_user"]
        total_bet_amount <- map["total_bet_amount"]
    }
    var bet_amount: String = "0"
    var new_register: NSNumber = 0
    var next_agent: NSNumber = 0
    var profits: String = "0"
    var recharge_amount: String = "0"
    var next_bet_amount: String = "0"
    var recharge_user: NSNumber = 0
    var total_bet_amount: String = "0"
}
class WLRptWebYesterdayInfoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        bet_amount <- map["bet_amount"]
        profits <- map["profits"]
        fee_amount <- map["fee_amount"]
        game_list <- map["game_list"]
        other_fee <- map["other_fee"]
        
    }
    var bet_amount: String = "0"
    var profits: String = "0"
    var fee_amount: String = "0"
    var game_list: [WLWebGameListDataModel] = []
    var other_fee: String = "0"
    
}
class WLWebGameListDataModel: Mappable {
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        bet <- map["bet"]
        bkge <- map["bkge"]
        proportion <- map["proportion"]
        game_name <- map["game_name"]
        fee <- map["fee"]
    }
    
    var bet: String = "0"
    var bkge: String = "0"
    var proportion: String = "0"
    var game_name: String = ""
    var fee: String = "0"
}
