//
//  ZKForgetPsw2ViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/14
//  
//
    

import UIKit

class ZKForgetPsw2ViewModel: ZKViewModel, ViewModelType {
    typealias ValidationResult = ZKHomeServer.ValidationResult
    struct Input {
        let code: Observable<String>
        let password: Observable<String>
        let repeatedPsd: Observable<String>
        let nextTap: Observable<Void>
    }
    
    struct Output {
        let valitionCode: Driver<ValidationResult>
        let validatedPassword: Driver<ValidationResult>
        let validatedRepeated: Driver<ValidationResult>
        let changeResult: Driver<ZKServerResult<Void>>
    }
    
    let phone: String
    let server = ZKHomeServer()
    
    init(phone: String) {
        self.phone = phone
    }
    
    func transform(input: Input) -> Output {
        
        let server = self.server
        let indicator = self.indicator
        
        
        let valitionCode = input.nextTap.withLatestFrom(input.code).map { code -> ValidationResult in
            if code.isEmpty {
                return .failed("login21".wlLocalized)
            }
            return .ok
        }.asDriver(onErrorJustReturn: .none(msg: "login21".wlLocalized))
        
        let validatedPassword = input.nextTap.withLatestFrom(input.password).map{ passwd -> ValidationResult in
            if passwd.isEmpty {
                return .failed("login23".wlLocalized)
            }
            return .ok
        }.asDriver(onErrorJustReturn: .none(msg: "login23".wlLocalized))
        
        let validatedRepeated = input.nextTap.withLatestFrom(Observable.combineLatest(input.password, input.repeatedPsd)).map{ server.validatedRepeated(password: $0, repeatedPassword: $1) }.asDriver(onErrorJustReturn: .none(msg: "login24".wlLocalized))
        
        let validattedResult = Observable.combineLatest(valitionCode.asObservable(), validatedPassword.asObservable(), validatedRepeated.asObservable()) {
            $0.isOK && $1.isOK && $2.isOK
        }
        
        let para = Observable.combineLatest(input.code, input.password) {
            ($0, $1)
        }
        
        let phone = self.phone
        let changeResult = validattedResult.filter{ $0 }.withLatestFrom(para).flatMapLatest { input -> Observable<ZKServerResult<Void>> in
            server.settingPassword(new: input.1, name: phone, code: input.0).trackActivity(indicator)
        }.asDriver(onErrorJustReturn: .failed(message: "error"))
        
        
        
        
       return Output(valitionCode: valitionCode, validatedPassword: validatedPassword, validatedRepeated: validatedRepeated, changeResult: changeResult)
        
//        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map { (second) -> Int in
//            return 180 - second
//        }.filter{ $0 >= 0 }
        
        
//        getCodeBtnSetResult = getCode.filter{ $0.isOK }.flatMapLatest{ _ in timer }.map {
//            $0 == 0 ? ( true, "noLogin15".wlLocalized ) : ( false, String($0) )
//        }
        
        
        
        
        
        
    }
}

