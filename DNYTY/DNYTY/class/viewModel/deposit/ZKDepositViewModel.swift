//
//  ZKDepositViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

//支付方式
enum ZKDepositMethod {
    case localBank
    case card
    case gcash
    case autoTopup
    
    var title: String {
        switch self {

        case .gcash:
            return "GCASH"
        case .card:
            return "recharge4".wlLocalized
        case .localBank:
            return "recharge5".wlLocalized
        case .autoTopup:
            return "Auto Topup"
        }
    }
    
    var detailTitle: String {
        switch self {
        case .card:
            return "recharge4".wlLocalized

        case .gcash:
            return "GCASH"
        case .localBank:
            return "recharge6".wlLocalized
        case .autoTopup:
            return "Auto Topup"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .card:
            return RImage.jiejika()
        case .gcash:
            return RImage.gcash()
        case .localBank:
            return RImage.xjzz()
        case .autoTopup:
            return RImage.auto_topup()
        }
    }
    
}

class ZKDepositViewModel: ZKViewModel, ViewModelType {
    struct Input {
        let viewWillShow: Observable<Void>
    }
    
    struct Output {
        let depositMethods: Driver<[SectionModel<String, ZKDepositMethod>]> //支付方式
        let account: Driver<String>
        let money: Driver<String>
        
    }
    
    let userServer = ZKUserServer()
    let walletServer = ZKWalletServer()
    
    func transform(input: Input) -> Output {
        let userServer = userServer
        let shardManger = ZKShareManager.shared
        let walletServer = walletServer
        
        let config = Observable.just(shardManger.config.value).unwrap().merge(with: userServer.startConfig().trackActivity(indicator))
        let depositMethods = config.map { config -> [ZKDepositMethod] in
            var depositMethods: [ZKDepositMethod] = []
            
            if config.rechargeQrcode {
                depositMethods.append(.gcash)
            }
            
            if config.rechargeOffline {
                depositMethods.append(.card)
            }
            if config.rechargeAutotopup {
                depositMethods.append(.localBank)
            }
            
            //depositMethods.append(.autoTopup)
            
            return depositMethods
        }.share()
        
        let depositMethodsOutput = depositMethods.map{
            [SectionModel(model: "", items: $0)]
        }.asDriver(onErrorJustReturn: [])
        
        let userInfo = Observable.just(shardManger.userInfo.value).merge(with: input.viewWillShow.flatMapLatest{ userServer.getUserInfo() }).unwrap()
        let wallet = Observable.just(shardManger.wallet.value).merge(with: input.viewWillShow.flatMapLatest{ walletServer.getWallet() }).unwrap()
        let account = userInfo.map { info in
            info.username
        }.asDriver(onErrorJustReturn: "")
        let money = wallet.map { wallet in
            (wallet.sumBalance/100).stringValue
        }.asDriver(onErrorJustReturn: "0")
        
       
        return Output(depositMethods: depositMethodsOutput, account: account, money: money)
        
    }
}
