//
//  ZKAutoTopupViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/7/1
//  
//
    

import UIKit

class ZKAutoTopupViewModel: ZKViewModel, ViewModelType {
    struct Input {
            
    }
    
    struct Output {
        let bankList: Driver<[ZKWalletServer.BankInfo]>
    }
    
    func transform(input: Input) -> Output {
        let server = ZKWalletServer()
        let bankList = server.getRechargeBank().trackActivity(indicator)
        return Output(bankList: bankList.asDriver(onErrorJustReturn: []))
    }
}
