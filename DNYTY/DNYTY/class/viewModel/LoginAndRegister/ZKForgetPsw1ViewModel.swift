//
//  ZKForgetPsw1ViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/14
//  
//
    

import UIKit

class ZKForgetPsw1ViewModel: ZKViewModel, ViewModelType {
    struct Input {
        let account: Observable<String>
        let getCodeTap: Observable<Void>
    }
    
    struct Output {
        let valitionAccount: Driver<ZKHomeServer.ValidationResult>
        let sendCodeResult: Driver<ZKServerResult<String>>
    }
    let server = ZKHomeServer()
    
    func transform(input: Input) -> Output {
        
        let server = self.server
        let indicator = self.indicator
        
        
        let valitionAccount = input.getCodeTap.withLatestFrom(input.account).map { account -> ZKHomeServer.ValidationResult in
            if account.isEmpty {
                return .failed("login18".wlLocalized)
            }
            return .ok
        }.asDriver(onErrorJustReturn: .none(msg: "login18".wlLocalized))
        
        let getCodeResult = valitionAccount.asObservable().filter{ $0.isOK } //验证成功
                                .withLatestFrom(input.account)   //开始获取验证码
                                .flatMapLatest{ server.getForgetCode(phone: $0).trackActivity(indicator) }.asDriver(onErrorJustReturn: .failed(message: ""))
        
       
        
//        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map { (second) -> Int in
//            return 180 - second
//        }.filter{ $0 >= 0 }
        
        
//        getCodeBtnSetResult = getCode.filter{ $0.isOK }.flatMapLatest{ _ in timer }.map {
//            $0 == 0 ? ( true, "noLogin15".wlLocalized ) : ( false, String($0) )
//        }
        
        
        
        
        return Output(valitionAccount: valitionAccount, sendCodeResult: getCodeResult)
        
    }
}
