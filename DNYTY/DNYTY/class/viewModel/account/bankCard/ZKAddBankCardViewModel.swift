//
//  ZKAddBankCardViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/22
//  
//
    

import UIKit
import RxRelay

class ZKAddBankCardViewModel: ZKViewModel, ViewModelType {
    typealias ValidationResult = ZKHomeServer.ValidationResult
    
    typealias Bank = ZKWalletServer.Bank
    struct Input {
        let name: Observable<String>
        let depositBank: Observable<String>
        let account: Observable<String>
//        let province: Observable<String>
//        let city: Observable<String>
        let addTap: Observable<Void>
    }
    
    struct Output {
        let bankList: Driver<[String]>
        let validatedSelectBank: Driver<ValidationResult>
        let addResult: Driver<ZKServerResult<String>>
    }
    
    let bankList: BehaviorRelay<[Bank]> = BehaviorRelay(value: [])
    let selectBank: BehaviorRelay<Bank?> = BehaviorRelay(value: nil)
    
    func transform(input: Input) -> Output {
        let server = ZKWalletServer()
        let bankList = server.getBankList().trackActivity(indicator).share()
        
        bankList.bind(to: self.bankList).disposed(by: rx.disposeBag)
        let bankListOutput = bankList.map{ $0.map{ $0.name } }.asDriver(onErrorJustReturn: [])
        
        let validatedSelectBank = input.addTap.withLatestFrom(selectBank).map { bank -> ValidationResult in
            if bank == nil {
                return .failed("errorTxt14".wlLocalized)
            }
            return .ok
        }.asDriverOnErrorJustComplete()
        
        let para = Observable.combineLatest(selectBank.unwrap(), input.name, input.depositBank, input.account )
        let addResult = input.addTap.withLatestFrom(para).flatMapLatest{ bank, name, depositBank, account in
            server.addCard(bankId: bank.id, depositBank: depositBank, name: name, account: account).trackActivity(self.indicator)
        }.asDriver(onErrorJustReturn: .failed(message: "error"))
        
        
        return Output(bankList: bankListOutput, validatedSelectBank: validatedSelectBank, addResult: addResult)
    }
    
}
