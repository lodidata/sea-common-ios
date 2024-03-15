//
//  WLAccountDataModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

struct WLAccountDataStruct {

    var imgName: String
    var title: String
}

class LevelModel: Mappable {
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        icon <- map["icon"]
        name <- map["name"]
        lotteryMoney <- map["lottery_money"]
        depositMoney <- map["deposit_money"]
        monthlyMoney <- map["monthly_money"]
        promoteHandsel <- map["promote_handsel"]
        
        transferHandsel <- map["transfer_handsel"]
        drawCount <- map["draw_count"]
        upgradeDmlPercent <- map["upgrade_dml_percent"]
        monthlyPercent <- map["monthly_percent"]
    }
    
    var icon: String = ""
    var name: String = ""
    var lotteryMoney: Double = 0  //投注
    var depositMoney: Double = 0 //充值
    var monthlyMoney: Double = 0 //月俸禄
    var promoteHandsel: Double = 0 //彩金
    
    var transferHandsel: String = ""
    var drawCount: Int = 0
    var upgradeDmlPercent: String = ""
    var monthlyPercent: String = ""
}

struct UserLevelInfo: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        username <- map["user_name"]
        avatar <- map["user_avatar"]
        levelName <- map["level_name"]
        levelIcon <- map["level_icon"]
        levelCurrent <- map["level_current"]
        levelCount <- map["level_count"]
        nextPercentDeposit <- map["next_percent_deposit"]
        nextPercentOrder <- map["next_percent_order"]
        privilege <- map["privilege"]
        
        orderAmount <- map["order_amount"]
        depositAmount <- map["deposit_amount"]
        nextLevelName <- map["next_level_name"]
        nextLevelIcon <- map["next_level_icon"]
        nextLevelOrder <- map["next_level_order"]
        nextLevelDeposit <- map["next_level_deposit"]
    }
    var privilege: [PrivilegeModel] = []
    var username: String = ""
    var avatar: String = ""
    var levelName: String = ""
    var levelIcon: String = ""
    var levelCurrent: Int = 0
    var levelCount: String = ""
    var nextPercentDeposit: Float = 0
    var nextPercentOrder: Double = 0
    
    var orderAmount: Double = 0
    var depositAmount: Double = 0
    var nextLevelName: String = ""
    var nextLevelIcon: String = ""
    var nextLevelOrder: Double = 0
    var nextLevelDeposit: Double = 0
    
    
    struct PrivilegeModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            name <- map["name"]
            type <- map["type"]
        }
        
        var name: String?
        var type: Int?
    }
}
