//
//  WLUserProfileDataModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/17.
//

import UIKit

class WLUserProfileDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        true_name <- map["true_name"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        gender <- map["gender"]
        
        updated <- map["updated"]
        wallet <- map["wallet"]
        level_name <- map["level_name"]
        level_icon <- map["level_icon"]
        user_name <- map["user_name"]
        wallet_id <- map["wallet_id"]
        ranting <- map["ranting"]
        tags <- map["tags"]
        last_login <- map["last_login"]
        agent_switch <- map["agent_switch"]
        mobile <- map["mobile"]
    }
    

    var true_name: String?
    var nickname: String?
    var avatar: String?
    var gender: NSNumber?
    var updated: String?
    var wallet: NSNumber?
    var level_name: String?
    var level_icon: String?
    var user_name: String?
    var wallet_id: NSNumber?
    var ranting: NSNumber?
    var tags: NSNumber?
    var last_login: NSNumber?
    var agent_switch: NSNumber?
    var mobile: String = ""
}
class WLBankBindDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        type <- map["type"]
        withdraw_pwd <- map["withdraw_pwd"]
        list <- map["list"]
        del_list <- map["del_list"]
    }
    
    var code: String?
    var type: NSNumber?
    var withdraw_pwd: NSNumber?
    var list: [WLBankBindListDataModel]?
    var del_list: [WLBankBindListDataModel]?

}
class WLBankBindListDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        account <- map["account"]
        bank_name <- map["bank_name"]
        short_name <- map["short_name"]
        deposit_bank <- map["deposit_bank"]
        time <- map["time"]
        shortname <- map["shortname"]
        updated <- map["updated"]
        state <- map["state"]
        h5_logo <- map["h5_logo"]
        logo <- map["logo"]
    }
    
    var id: NSNumber?
    var name: String?
    var account: String?
    var bank_name: String?
    var short_name: String?
    var deposit_bank: String?
    var time: NSNumber?
    var updated: String?
    var shortname: String?
    var state: String?
    var h5_logo: String?
    var logo: String?

}
class WLWallet: Mappable  {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        sumBalance <- map["sum_balance"]
        availableBalance <- map["available_balance"]
        freezeMoney <- map["freeze_money"]
        takeBalance <- map["take_balance"]
        todayProfit <- map["today_profit"]
        child <- map["child"]
    }
    
    var sumBalance: NSNumber = 0
    var availableBalance: NSNumber = 0
    var freezeMoney: NSNumber = 0
    var takeBalance: NSNumber = 0
    var todayProfit: String = "0"
    var child: [WLThirdWalletChildModel] = []
}
class WLThirdWalletChildModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        balance <- map["balance"]
        freeMoney <- map["freeMoney"]
        uuid <- map["uuid"]
        game_type <- map["game_type"]
        name <- map["name"]
    }
    var balance: NSNumber = 0
    var freeMoney: NSNumber = 0
    var uuid: String = ""
    var game_type: String = ""
    var name: String = ""

}
