//
//  ZKUserServer.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKUserServer: NSObject {
    // MARK: 启动配置
    struct Config: Mappable {
        init?(map: Map) {
            
        }
        
        init() {
            
        }
        
        mutating func mapping(map: Map) {
            kefuUrl <- map["code"]
            logo <- map["site_h5_logo"]
            rechargeAutotopup <- map["recharge_autotopup"]
            rechargeOffline <- map["recharge_offline"]
            rechargeQrcode <- map["recharge_qrcode"]
            minMoney <- map["min_money"]
            maxMoney <- map["max_money"]
            rechargeMoneyList <- map["recharge_money_value_list"]
        }
        
        var minMoney: Double = 0
        var maxMoney: Double = 0
        var logo: String = ""
        var kefuUrl: String = ""
        var rechargeAutotopup: Bool = false
        var rechargeOffline: Bool = false  //线下，转卡
        var rechargeQrcode: Bool = false
        var rechargeMoneyList: [Double] = []
    }
    
    func startConfig() -> Observable<Config> {
        let ob = ZKProvider.rx.request(.startConfig).mapServerObject(Config.self).asObservable().unwrap().do { config in
            ZKShareManager.shared.config.accept(config)
        }.share()
        return ob
    }
    
    //MARK: 用户信息
    struct UserInfo: Mappable {
        init() {
            
        }
        
        init?(map: Map) {
        }
        
        mutating func mapping(map: Map) {
            username <- map["user_name"]
            walletid <- map["wallet_id"]
            //wallet <- map["wallet"]
            avatar <- map["avatar"]
            ranting <- map["ranting"]
            levelname <- map["level_name"]
            levelicon <- map["level_icon"]
            truename <- map["true_name"]
            nickname <- map["nickname"]
            agentSwitch <- map["agent_switch"]
            
        }
        var agentSwitch: Bool = false
        var username: String = ""
        var nickname: String = ""
        var truename: String = ""
        var walletid: Int = 0
        //var wallet: Double = 0
        var avatar: String = ""
        var ranting: String = ""
        var levelname: String = ""
        var levelicon: String = ""
        
        var password: String = ""
        
    }
    
    func getUserInfo() -> Observable<UserInfo?> {
        ZKProvider.rx.request(.profile).mapServerObject(UserInfo.self).do { userinfo in
            ZKShareManager.shared.userInfo.accept(userinfo)
        }.asObservable()
    }
    
    struct LevelModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            icon <- map["icon"]
            name <- map["name"]
            depositMoney <- map["deposit_money"]
            lotteryMoney <- map["lottery_money"]
            monthlyMoney <- map["monthly_money"]
            promoteHandsel <- map["promote_handsel"]
            transferHandsel <- map["transfer_handsel"]
        }
        
        var icon: String = ""
        var name: String = ""
        var depositMoney: Double = 0
        var lotteryMoney: Double = 0
        var monthlyMoney: Double = 0
        var promoteHandsel: Double = 0
        var transferHandsel: String = "0"
    }
    func getLevelExplainList() -> Observable<[LevelModel]> {
        ZKProvider.rx.request(.levelExplain).mapServerArray(LevelModel.self).asObservable()
    }
    
    struct UserLevel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            levelName <- map["level_name"]
        }
        
        var levelName: String = ""
    }
    
    //用户等级
    func getUserLevel() -> Observable<UserLevel?> {
        ZKProvider.rx.request(.userLevelInfo).mapServerObject(UserLevel.self).asObservable()
    }
}
