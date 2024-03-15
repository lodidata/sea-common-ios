//
//  ZKWalletServer.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit
import SwiftyJSON

class ZKWalletServer: NSObject {
    
    // MARK: 获取钱包
    struct Wallet: Mappable  {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            sumBalance <- map["sum_balance"]
            availableBalance <- map["available_balance"]
            freezeMoney <- map["freeze_money"]
            takeBalance <- map["take_balance"]
            todayProfit <- map["today_profit"]
            child <- map["child"]
        }
        
        var sumBalance: Double = 0
        var availableBalance: Double = 0
        var freezeMoney: Double = 0
        var takeBalance: Double = 0
        var todayProfit: Double = 0
        var child: [ZKThirdWalletChildModel] = []
    }
    
    struct ZKThirdWalletChildModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            balance <- map["available_balance"]
            freeMoney <- map["available_balance"]
            uuid <- map["uuid"]
            game_type <- map["game_type"]
            name <- map["name"]
            sumBalance <- map["sum_balance"]
        }
        var sumBalance: Double = 0
        var balance: Double = 0
        var freeMoney: Double = 0
        var uuid: String = ""
        var game_type: String = ""
        var name: String = ""
        
    }
    
    func getWallet() -> Observable<Wallet?> {
        ZKProvider.rx.request(.thirdList(refresh: 0)).mapServerObject(Wallet.self).do{ wallet in
            ZKShareManager.shared.wallet.accept(wallet)
        }.asObservable()
    }
    
    // MARK: 支付渠道
    
    struct PayChannel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            payId <- map["pay_id"]
            name <- map["name"]
            maxMoney <- map["max_money"]
            minMoney <- map["min_money"]
            //payType <- map["pay_type"]
        }
        
        //var payType: [Dictionary] = []
        var id: Int = 0
        var payId: Int = 0
        var name: String = ""
        var maxMoney: Double = 0
        var minMoney: Double = 0
    }
    
    func payTypeList() -> Observable<[PayChannel]> {
        ZKProvider.rx.request(.payTypeList).mapServerArray(PayChannel.self).asObservable()
    }
    
    // MARK: 充值
    //线上
    func rechargeOnlines(payId: Int, bankData: String = "", money: String) -> Observable<ZKServerResult<URL?>> {
        ZKProvider.rx.request(.rechargeOnlines(receiptId: payId , bankData: bankData, money: money)).mapServerJSON({ state, json, message -> ZKServerResult<URL?> in
            guard state == 0 else {
                return .failed(message: message)
            }
            
            return .respone(URL(string: json["url"].stringValue))
        }, failsOnEmpty: false).catch{ error in
            .just(.failed(message: error.localizedDescription))
        }.asObservable()
        
    }
    
    // MARK: 获取银行账号
    struct BankInfo: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
            card <- map["card"]
            bankName <- map["bank_name"]
            code <- map["code"]
            bankImg <- map["bank_img"]
            qrCode <- map["qrcode"]
        }
        
        var id: Int = 0
        var name: String = ""
        var card: String = ""
        var bankName: String = ""
        var code: String = ""
        var bankImg: String = ""
        var qrCode: String = ""
        
        var qrCodeUrl: URL? {
            return URL(string: qrCode)
        }
    }
    func getBankAccountList() -> Observable<[BankInfo]> {
        ZKProvider.rx.request(.bankAccount).mapServerArray(BankInfo.self).asObservable()
    }
    
    // MARK: 获取绑定的银行账号
    struct BindCardInfo: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            bankName <- map["bank_name"]
            logo <- map["h5_logo"]
            account <- map["account"]
            name <- map["name"]
            id <- map["id"]
        }
        var id: Int = 0
        var name: String = ""
        var bankName: String = ""
        var logo: String = ""
        var account: String = ""
    }
    
    
    func getBindBankList() -> Observable<[BindCardInfo]> {
        ZKProvider.rx.request(.wlUserBankBind).mapServerJSON { _, json, _ in
            json["list"].mapObjectArray(type: BindCardInfo.self)
        }.asObservable()
    }
    
    //删除银行卡
    func deleteCard(id: Int) -> Observable<String> {
        ZKProvider.rx.request(.deletCard(id: id)).mapServerJSON { _, _, msg in
            msg
        }.asObservable()
    }
    
    //线下
    func rechargeOfflines(money: String, card: BindCardInfo, bank: BankInfo, time: String) -> Observable<ZKServerResult<String>> {
        ZKProvider.rx.request(.rechargeOfflines(bankId: card.id, depositName: card.name, receiptId: bank.id, money: money, depositTime: time)).mapServerJSON({ state, json, message -> ZKServerResult<String> in
            guard state != 884 else {
                return .failed(message: message)
            }
            
            return .respone(message)
        }, failsOnEmpty: false).catch{ error in
            .just(.failed(message: error.localizedDescription))
        }.asObservable()
    }
    
    // MARK: 存款记录
    struct DepositModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            time <- map["created"]
            money <- map["money"]
            status <- map["status"]
            tradeNo <- map["trade_no"]
        }
        
        var time: String = ""
        var money: Double = 0
        var status: String = ""
        var tradeNo: String = ""
//        var statusDescription: String {
//            switch status {
//            case "paid":
//                return "withdraw19".wlLocalized
//            case "pending":
//                return "withdraw20".wlLocalized
//            case "failed":
//                return "withdraw21".wlLocalized
//            case "canceled":
//                return "withdraw22".wlLocalized
//            case "rejected":
//                return "withdraw18".wlLocalized
//            default:
//                return ""
//            }
//        }
    }
    
    
    func getDepositList(strat: String = "", end: String = "", page: Int) -> Observable<(page: Int, total: Int, data: [DepositModel])> {
        ZKProvider.rx.request(.depositList(start: strat, end: end, page: page, pageSize: 10)).mapServerJSON { state, json, msg, attr in
            
            return (attr["number"].intValue, attr["total"].intValue, json.mapObjectArray(type: DepositModel.self) )
        }.asObservable()
    }
    
    //MARK: 取款记录
    struct WithdrawModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            time <- map["created"]
            money <- map["money"]
            status <- map["status"]
        }
        
        var time: String = ""
        var money: Double = 0
        var status: String = ""
        var tradeNo: String = ""
//        var statusDescription: String {
//            switch status {
//            case "paid":
//                return "withdraw19".wlLocalized
//            case "pending":
//                return "withdraw20".wlLocalized
//            case "failed":
//                return "withdraw21".wlLocalized
//            case "canceled":
//                return "withdraw22".wlLocalized
//            case "rejected":
//                return "withdraw18".wlLocalized
//            default:
//                return ""
//            }
//        }
    }
    
    
    func getWithdrawList(strat: String = "", end: String = "", page: Int) -> Observable<(page: Int, total: Int, data: [WithdrawModel])> {
        ZKProvider.rx.request(.withdrawList(start: strat, end: end, page: page, pageSize: 10)).mapServerJSON { _, json, _, attr in
            (attr["number"].intValue, attr["total"].intValue, json.mapObjectArray(type: WithdrawModel.self) )
        }.asObservable()
    }
    
    //公告
    func getNoticeList() -> Observable<[WLNoticeAppDataModel]> {
        ZKProvider.rx.request(.wlNoticeApp).mapServerArray(WLNoticeAppDataModel.self).asObservable()
    }
    
    //银行列表
    struct Bank: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
        }
        
        
        
        var id: Int = 0
        var name: String = ""
    }
    
    func getBankList() -> Observable<[Bank]> {
        ZKProvider.rx.request(.bankList).mapServerJSON{ _, json, _ in
            json["list"].mapObjectArray(type: Bank.self)
        }.asObservable()
    }
    //新增银行卡
    func addCard(bankId: Int, depositBank: String, name: String, account: String) -> Observable<ZKServerResult<String>> {
        ZKProvider.rx.request(.addBankCard(bankId: bankId, depositBank: depositBank, name: name, account: account)).mapServerJSON({ state, _, message in
            if state == 0 {
                return .respone(message)
            }
            
            return .failed(message: message)
        }, failsOnEmpty: false).catch{ error in
                .just(.failed(message: error.localizedDescription))
        }.asObservable()
    }
    
    //账户详情类型
    struct CapitalType: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            name <- map["name"]
        }
        
        
        var id: Int = 0
        var name: String = ""
    }
    
    func getCapitalTypeList(type: Int = 1) -> Observable<[CapitalType]> {
        ZKProvider.rx.request(.capitalTypeList(type: type)).mapServerJSON { _, json, _ in
            json["type"].mapObjectArray(type: CapitalType.self)
        }.asObservable()
    }
    
    //账号详情
    struct CapitalModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            time <- map["created"]
            gameType <- map["game_type"]
            money <- map["money"]
            orderNumber <- map["order_number"]
        }
        
        
        var time: String = ""
        var gameType: String = ""
        var money: Double = 0
        var orderNumber: String = ""
        
        var type: String {
            guard let index = Int(gameType) else { return gameType }
            
            switch index {
            case 0:
                return "type2Txt1".wlLocalized
            case 1:
                return "type2Txt2".wlLocalized
            case 2:
                return "type2Txt3".wlLocalized
            case 3:
                return "type2Txt4".wlLocalized
            case 4:
                return "type2Txt5".wlLocalized
            case 5:
                return "type2Txt6".wlLocalized
            case 6:
                return "type2Txt7".wlLocalized
            case 7:
                return "type2Txt8".wlLocalized
            case 8:
                return "type2Txt9".wlLocalized
            case 9:
                return "type2Txt10".wlLocalized
            case 10:
                return "type2Txt11".wlLocalized
            default:
                return gameType
            }
            
        }
    }
    
    func getCapitalList(type: Int, gameType: Int, start: String, end: String, page: Int) -> Observable<(page: Int, total: Int, data: [CapitalModel])> {
        ZKProvider.rx.request(.capitalList(type: type, gameType: gameType, start: start, end: end, page: page, pageSize: 10)).mapServerJSON { state, json, msg, attr in
            
            return (attr["number"].intValue, attr["total"].intValue, json.mapObjectArray(type: CapitalModel.self) )
        }.asObservable()
    }
    
    //红利
    struct ApplyModel: Mappable {
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            time <- map["apply_time"]
            name <- map["active_name"]
            money <- map["coupon_money"]
        }
        
        var time: String = ""
        var name: String = ""
        var money: Double = 0
    }
    
    func getApplyList(page: Int) -> Observable<(page: Int, total: Int, data: [ApplyModel])> {
        ZKProvider.rx.request(.wlActiveApplys(page: page, page_size: 10)).mapServerJSON { state, json, msg, attr in
            return (attr["number"].intValue, attr["total"].intValue, json.mapObjectArray(type: ApplyModel.self) )
        }.asObservable()
    }
    
    func getRechargeBank() -> Observable<[BankInfo]> {
        ZKProvider.rx.request(.getAutotopup).mapServerArray(BankInfo.self).asObservable()
    }
    
}
