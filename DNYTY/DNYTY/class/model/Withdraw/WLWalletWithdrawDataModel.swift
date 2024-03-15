//
//  WLWalletWithdrawDataModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/16.
//

import UIKit
import ObjectMapper

class WLWalletWithdrawDataModel: Mappable {

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        balance <- map["balance"]
        require_bet <- map["require_bet"]
        withdraw_money <- map["withdraw_money"]
        withdraw_card <- map["withdraw_card"]
        info <- map["info"]
    }
    

    var balance: NSNumber?
    var require_bet: NSNumber?
    
    var withdraw_money: WLWalletWithdrawMoenyDataModel?
    var withdraw_card: [WLWalletWithdrawCardDataModel]?
    var info: WLWalletWithdrawInfoDataModel?
}
class WLWalletWithdrawMoenyDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        min <- map["min"]
        max <- map["max"]
        times <- map["times"]
        end <- map["end"]
        start <- map["start"]
    }

    var min: NSNumber?
    var max: NSNumber?
    var times: NSNumber?
    var end: String?
    var start: String?
    
}
class WLWalletWithdrawCardDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        bank_name <- map["bank_name"]
        created_time <- map["created_time"]
        state <- map["state"]
        shortname <- map["shortname"]
        updated_time <- map["updated_time"]
        code <- map["code"]
        card <- map["card"]
        name <- map["name"]
    }

    var id: NSNumber?
    var bank_name: String?
    var created_time: String?
    var state: String?
    var shortname: String?
    var updated_time: String?
    var code: String?
    var card: String?
    var name: String?
    
    
}
class WLWalletWithdrawInfoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        counter_fee <- map["counter_fee"]
        government_fee <- map["government_fee"]
        Discount <- map["Discount"]
    }

    var counter_fee: NSNumber?
    var government_fee: NSNumber?
    var Discount: NSNumber?
    
}
class WLWalletWithdrawHistoryDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
//        user_id <- map["user_id"]
        trade_no <- map["trade_no"]
        money <- map["money"]
        status <- map["status"]
        created <- map["created"]
        updated <- map["updated"]
        confirm_time <- map["confirm_time"]
        receive_bank_info <- map["receive_bank_info"]
    }

    var id: NSNumber?
//    var user_id: NSNumber?
    var trade_no: String?
    var money: NSNumber?
    var status: String?
    var created: String?
    var updated: String?
    var confirm_time: String?
    var receive_bank_info: WLReceiveBankInfoDataModel?
    
}
class WLWalletWithdrawHistoryAttributeDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total <- map["total"]
    }

    var total: NSNumber = 0
    
}

class WLReceiveBankInfoDataModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        bank <- map["bank"]
        name <- map["name"]
        card <- map["card"]
        address <- map["address"]
        bank_code <- map["bank_code"]
    }

    var bank: String = ""
    var name: String = ""
    var card: String = ""
    var address: String = ""
    var bank_code: String = ""
}
