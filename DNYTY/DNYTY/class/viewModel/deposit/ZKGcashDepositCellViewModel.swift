//
//  ZKGcashDepositCellViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/16
//  
//
    

import UIKit
import RxRelay
import RxCocoa

class ZKGcashDepositCellViewModel: ZKViewModel {
    typealias PayChannel = ZKWalletServer.PayChannel
    let isShow: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let submitTap: PublishRelay<(PayChannel, String)> = PublishRelay()
    let channel: PayChannel
    let moneyPlaceholder: String
    let name: String
    let quota: String
    let moneyList: [String]
    
    init(channel: PayChannel, moneyList: [String]) {
        self.channel = channel
        self.moneyList = moneyList
        name = channel.name
        quota = "recharge22" + " " + (channel.minMoney/100).stringValue + "-" +  (channel.maxMoney/100).stringValue
        moneyPlaceholder = (channel.minMoney/100).stringValue + "-" + (channel.maxMoney/100).stringValue
    }
}
