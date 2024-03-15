//
//  WLRegisterViewModel.swift
//  DNYTY
//
//  Created by wulin on 2022/6/9.
//

import UIKit
import Alamofire
import RxCocoa



class WLRegisterViewModel: ZKViewModel, ViewModelType {
    typealias ValidationResult = ZKHomeServer.ValidationResult
    
    struct Input {
        let accountOb: Observable<String>
        let pwdOb: Observable<String>
        let comfirmPwdOb: Observable<String>
        let phoneOb: Observable<String>
        let invitCodeOb: Observable<String>
        let getCodeOb: Observable<Void> //获取验证码
        let codeOb: Observable<String>
        let recommendOb: Observable<String>
        let protocolisSelectOb: Observable<Bool>
        let protocolClickOb: Observable<Void>
        let registerOb: Observable<Void>
        
    }
    
    struct Output {
        let validatedUsername: Driver<ValidationResult>
        let validatedPassword: Driver<ValidationResult>
        let validatedRepeated: Driver<ValidationResult>
        let getOtpText: Driver<String>
        let getOtpEnable: Driver<Bool>
        let validatedCode: Driver<ValidationResult>
        let registerResult: Driver<ZKHomeServer.ZKRegisterResult>
        let protocolOK: Driver<Bool>
    }
    
    let server = ZKHomeServer()
    
    
    
    func transform(input: Input) -> Output {
       
        let server = self.server
        
        let validatedUsername = input.registerOb.withLatestFrom(input.accountOb).map { server.validatedUsername(userName: $0) }.asDriver(onErrorJustReturn: .none(msg: "login6".wlLocalized))
        let validatedPassword = input.registerOb.withLatestFrom(input.pwdOb).map{
            server.validatedPassword(password: $0)
        }.asDriver(onErrorJustReturn: .none(msg: "login7".wlLocalized))
        let validatedRepeated = input.registerOb.withLatestFrom(Observable.combineLatest(input.pwdOb, input.comfirmPwdOb)).map{ server.validatedRepeated(password: $0, repeatedPassword: $1) }.asDriver(onErrorJustReturn: .none(msg: "login8".wlLocalized))
        
        let validatedPhone = input.getCodeOb.withLatestFrom(input.phoneOb).flatMap{ phone -> Observable<ValidationResult> in
            let result = server.validatedPhone(phone: phone)
            
            if case ValidationResult.failed(let msg) = result {
                DefaultWireFrame.showPrompt(text: msg)
            }
            
            return .just(result)
        }.share()
        
        //倒计时
        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map { (second) -> Int in
            return 180 - second
        }.filter{ $0 >= 0 }
        
        //获取验证码
        let requestOTP = validatedPhone.filter{ $0.isOK }.withLatestFrom(input.phoneOb).flatMapLatest { [weak self] phone -> Observable<ZKServerResult<String>> in
            guard let self = self else {
                return .never()
            }
            return server.getOTP(phone: phone).trackActivity(self.indicator)
        }.share(replay: 1)
        
        requestOTP.bind { resp in
            switch resp {
            case .respone(let code):
                //DefaultWireFrame.showPrompt(text: "验证码发送成功")
                print("code:", code)
            case .failed(let msg):
                DefaultWireFrame.showPrompt(text: msg)
            
            }
        }.disposed(by: rx.disposeBag)
        
        let startTimer = requestOTP.filter{ $0.isOK }.flatMapLatest{ _ in timer }.share()
        
        //发送验证码文本
        let getOtpText = startTimer.map { time in
            time == 0 ? "login11".wlLocalized : String(time)
        }.asDriver(onErrorJustReturn: "login11".wlLocalized)
        
        //发送验证码交互
        let getOtpEnable = startTimer.map { time in
            time == 0 ? true : false
        }.asDriver(onErrorJustReturn: true)
        
        //验证码
        let validatedCode = input.registerOb.withLatestFrom(input.accountOb).map { server.validatedCode(code: $0) }.asDriver(onErrorJustReturn: .none(msg: "login13".wlLocalized))
        
        //协议
        let protocolOK = input.registerOb.withLatestFrom(input.protocolisSelectOb).asDriver(onErrorJustReturn: false)
        
        let validatedResult = Observable.combineLatest(validatedUsername.asObservable(), validatedRepeated.asObservable(), validatedPhone.asObservable(), validatedCode.asObservable(), protocolOK.asObservable()) { v1, v2, v3, v4, v5 -> Bool in
            if case ValidationResult.failed(let msg) = v3 {
                DefaultWireFrame.showPrompt(text: msg)
            }
            
            return v1.isOK && v2.isOK && v3.isOK && v4.isOK && v5
        }
        
        
        
        let para = Observable.combineLatest(input.accountOb, input.pwdOb, input.phoneOb, input.codeOb, input.invitCodeOb)
        
        let registerResult = input.registerOb.withLatestFrom(validatedResult).filter{ $0 }.withLatestFrom(para).flatMapLatest { userName, password, phone, code, invitCode in server.requestRegister(userName: userName, mobile: phone, password: password, verifyCode: code, invitCode: invitCode).trackActivity(self.indicator) }.asDriver(onErrorJustReturn: .failed("error"))
        
        return Output(validatedUsername: validatedUsername, validatedPassword: validatedPassword, validatedRepeated: validatedRepeated, getOtpText: getOtpText, getOtpEnable: getOtpEnable, validatedCode: validatedCode, registerResult: registerResult, protocolOK: protocolOK)
    }
    
    
}
