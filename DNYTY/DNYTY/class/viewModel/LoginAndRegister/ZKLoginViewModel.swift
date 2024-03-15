//
//  ZKLoginViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit

class ZKLoginViewModel: ZKViewModel, ViewModelType {
    
    typealias ValidationResult = ZKHomeServer.ValidationResult

    struct Input {
        let account: Observable<String>
        let password: Observable<String>
        let code: Observable<String>
        let refreshCode: Observable<Void>
        let loginTap: Observable<Void>
    }
    
    struct Output {
        let validatedUsername: Driver<ValidationResult>
        let validatedPassword: Driver<ValidationResult>
        
        let loginSucceed: Driver<Bool>
        let hideCaptcha: Driver<Bool>
        let captcha: Driver<UIImage?>
    }
    
    let server = ZKHomeServer()
    
    
    func transform(input: Input) -> Output {
        
        let validatedUsername = input.loginTap.withLatestFrom(input.account).map{
            self.validatedUsername(userName: $0)
        }.asDriver(onErrorJustReturn: .none(msg: "login4".wlLocalized))
        let validatedPassword = input.loginTap.withLatestFrom(input.password).map{
            self.validatedPassword(password: $0)
        }.asDriver(onErrorJustReturn: .none(msg: "login5".wlLocalized))
        
        let validateSucceend = Observable.combineLatest(validatedUsername.asObservable(), validatedPassword.asObservable()){
            $0.isOK && $1.isOK
        }.filter{ $0 }
        
        let captcha: BehaviorRelay<ZKHomeServer.ZKCaptchaImage?> = BehaviorRelay(value: nil) //验证码
        
        
    
        
        let loginPara = Observable.combineLatest(input.account, input.password, input.code, captcha.asObservable()) {
            return (username: $0, password: $1, code: $2, token: $3?.token)
        }
        
        
        //登录结果
        let loginResult = validateSucceend.withLatestFrom(loginPara)
                                  .flatMapLatest { para in
                                      self.server.login(username: para.username, password: para.password, code: para.code, token: para.token).trackActivity(self.indicator)
                                  }.share()
        
        
        //需要获取验证码
        loginResult.filter {
            $0.isCaptcha
        }.mapToVoid().merge(with: input.refreshCode).flatMapLatest{ _ in self.server.getCaptchaImage().trackActivity(self.indicator) }.bind(to: captcha).disposed(by: rx.disposeBag)
        
        //登录成功
        let loginSucceed = loginResult.withLatestFrom(loginPara){ loginResult, loginPara -> Bool in
            
            switch loginResult {
            case .ok(let model):
                ZKLoginUser.shared.save(model: model)
                UserDefaults.standard.set(loginPara.username, forKey: kUserNameKey)
                UserDefaults.standard.set(loginPara.password, forKey: kUserPasswordKey)
                
            default:
                DefaultWireFrame.showPrompt(text: loginResult.errMsg)
            }
            
            if loginResult.isOK {
                
            }
            
            return loginResult.isOK
        }.asDriver(onErrorJustReturn: false)
        
        let hideCaptcha = loginResult.map{ !$0.isCaptcha }.asDriver(onErrorJustReturn: true)
        
        let captchaOutput = captcha.unwrap().map{ $0.image }.asDriver(onErrorJustReturn: nil)
        
      
        return Output(validatedUsername: validatedUsername, validatedPassword: validatedPassword, loginSucceed: loginSucceed, hideCaptcha: hideCaptcha, captcha: captchaOutput)
    }
    
    
    func validatedUsername(userName: String ) -> ValidationResult {
        if userName.isEmpty {
            return .failed("login4".wlLocalized)
        }
        return .ok
    }
    
    func validatedPassword(password: String ) -> ValidationResult {
        if password.isEmpty {
            return .failed("login5".wlLocalized)
        }
        return .ok
    }
    
}
