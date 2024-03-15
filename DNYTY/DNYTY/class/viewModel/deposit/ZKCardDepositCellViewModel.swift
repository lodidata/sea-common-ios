//
//  ZKCardDepositCellViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/16
//  
//
    

import UIKit
import RxRelay

class ZKCardDepositCellViewModel: ZKViewModel {
    struct Bank {
        let name: String
        let value: String
    }
    
    
    typealias PayChannel = ZKWalletServer.PayChannel
    let isShow: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let submitTap: PublishRelay<String> = PublishRelay()
    let selectBankIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let selectBankName: BehaviorRelay<String>
    
    let channel: PayChannel
    let moneyPlaceholder: String
    let name: String
    let quota: String
    let bankList: [Bank]
    let bankNames: [String]
    
    init(channel: PayChannel) {
        self.channel = channel
        name = channel.name
        quota = "recharge22".wlLocalized + " " + (channel.minMoney/100).stringValue + "-" +  (channel.maxMoney/100).stringValue
        moneyPlaceholder = (channel.minMoney/100).stringValue + "-" + (channel.maxMoney/100).stringValue
        
        bankList = [
            Bank(name: "BPI", value: "BPIA"),
            Bank(name: "Union Bank of the Philippine", value: "UBPB"),
            Bank(name:  "rizal commercial banking…", value: "RCBC")
        ]
        
        bankNames = bankList.map{ $0.name }
        selectBankName = BehaviorRelay(value: bankList[0].name)
        
        super.init()
        
        selectBankIndex.map {[weak self] index -> String in
            guard let self = self else { return "" }
            return self.bankList[index].name
        }.bind(to: selectBankName).disposed(by: rx.disposeBag)
        
    }
}
