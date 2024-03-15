//
//  ZKLocalBankDepostViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit
import RxRelay
import Alamofire

class ZKLocalBankDepostViewModel: ZKViewModel, ViewModelType {
    typealias ValidationResult = ZKHomeServer.ValidationResult
    typealias BankInfo = ZKWalletServer.BankInfo
    typealias Card = ZKWalletServer.BindCardInfo
    struct Input {
        let viewWillShow: Observable<Void>
        let bankSelectIndex: Observable<Int>
        let name: Observable<String>
        let money: Observable<String>
        let submitTap: Observable<Void>
        let kefuTap: Observable<Void>
    }
    
    struct Output {
        let bankList: Driver<[BankInfo]>
        let validatedBindCard: Driver<ValidationResult>
        let validatedName: Driver<ValidationResult>
        let validatedMoney: Driver<ValidationResult>
        let depositResult: Driver<ZKServerResult<String>>
        let openKefu: Driver<URL?>
    }
    
    let selectBank: BehaviorRelay<BankInfo?> = BehaviorRelay(value: nil)
    
    let binkCardList: BehaviorRelay<[Card]> = BehaviorRelay(value: [])
    let selectCard: BehaviorRelay<Card?> = BehaviorRelay(value: nil)
    let selectDate: BehaviorRelay<String>
    let selectHour: BehaviorRelay<String>
    let selectMinute: BehaviorRelay<String>
    
    let hours: [String]
    let minutes: [String]
    
    override init() {
        let gregorian = Calendar(identifier: .gregorian)
        let date = Date()
        let dateComponents = gregorian.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        selectDate = BehaviorRelay(value: String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!))
        selectHour = BehaviorRelay(value: String(dateComponents.hour!))
        selectMinute = BehaviorRelay(value: String(dateComponents.minute!))
        
        var hourTitles: [String] = []
        for hour in 0..<24 {
            hourTitles.append(String(format: "%02d", hour))
        }
        hours = hourTitles
        
        var minuteTitles: [String] = []
        for minute in 0..<60 {
            minuteTitles.append(String(format: "%02d", minute))
        }
        minutes = minuteTitles
    }
    
    let server = ZKWalletServer()
    
    func transform(input: Input) -> Output {
        let server = self.server
        let userServer = ZKUserServer()
        let indicator = self.indicator
        
        //银行
        let bankList = server.getBankAccountList().trackActivity(indicator).share()
        bankList.filter{ [weak self] list in
            guard let self = self else { return false }
            return list.count != 0 && self.selectCard.value == nil
        }.map{ $0[0] }.bind(to: selectBank).disposed(by: rx.disposeBag)
       
        input.bankSelectIndex.withLatestFrom(bankList){ $1[$0] }.bind(to: selectBank).disposed(by: rx.disposeBag)
        let bankListOutput = bankList.asDriver(onErrorJustReturn: [])
        
        //绑定的银行卡
        let bindCardList = input.viewWillShow.flatMapLatest{ server.getBindBankList().trackActivity(indicator).share() }.share()
        bindCardList.bind(to: binkCardList).disposed(by: rx.disposeBag)
        bindCardList.filter{ $0.count != 0 }.compactMap{ $0.first }.bind(to: selectCard).disposed(by: rx.disposeBag)
        
        //
        let config = userServer.startConfig().share()
        
        //验证
        let validatedBindCard = input.submitTap.withLatestFrom(selectCard).map { card -> ValidationResult in
            if card == nil {
                return .failed("withdraw14".wlLocalized)
            }
            return .ok
        }
        
        let validatedName = input.submitTap.withLatestFrom(input.name).map { name -> ValidationResult in
            if name.isEmpty {
                return .failed("withdraw14".wlLocalized)
            }
            return .ok
        }
        
        let moneyInput = Observable.combineLatest(config, input.money)
        let validatedMoney = input.submitTap.withLatestFrom(moneyInput).map { config, money -> ValidationResult in
            guard let moneyNumber = Double(money) else { return .failed("new9".wlLocalized) }
            if moneyNumber > config.maxMoney/100 {
                return .failed("errorTxt17".wlLocalized + " " + (config.maxMoney/100).stringValue)
            }
            
            if moneyNumber < config.minMoney/100 {
                return .failed("errorTxt7".wlLocalized + " " + (config.minMoney/100).stringValue)
            }
            
            if money.isEmpty {
                return .failed("withdraw14".wlLocalized)
            }
            return .ok
        }
        
        let selectTime = Observable.combineLatest(selectDate, selectHour, selectMinute) { date, hour, minute in
            date + " " + hour + ":" + minute + ":" + "00"
        }
        
        let validateResult = Observable.combineLatest(validatedBindCard, validatedName, validatedMoney) {
            $0.isOK && $1.isOK && $2.isOK
        }
        
        let para = Observable.combineLatest(selectBank,selectCard, input.name, input.money, selectTime) { ($0,$1,$2,$3, $4) }
        
        let depositResult = input.submitTap.withLatestFrom(validateResult).filter{ $0 }.withLatestFrom(para).flatMapLatest { bank, card, name, money, selectTime -> Observable<ZKServerResult<String>> in
            
            guard let bank = bank else {
                DefaultWireFrame.showPrompt(text: "new10".wlLocalized)
                return .never()
            }
            
            guard let card = card else {
                return .never()
            }
            
            return server.rechargeOfflines(money: (Double(money)!*100).stringValue, card: card, bank: bank, time: selectTime).trackActivity(indicator)
        }.asDriver(onErrorJustReturn: .failed(message: "error"))
        
        let kefuOpen = input.kefuTap.withLatestFrom(config).map{ config -> URL? in
            let url = URL(string: config.kefuUrl)
            return url
        }.asDriver(onErrorJustReturn: nil)
        
        return Output(bankList: bankListOutput, validatedBindCard: validatedBindCard.asDriverOnErrorJustComplete(), validatedName: validatedName.asDriverOnErrorJustComplete(), validatedMoney: validatedMoney.asDriverOnErrorJustComplete(), depositResult: depositResult, openKefu: kefuOpen)
    }

}
