//
//  ZKFinancialViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit
import RxRelay
import RxCocoa

class ZKFinancialViewModel: ZKViewModel, ViewModelType {
    
    
    struct Input {
        let searchTap: Observable<Void>
        let startDateTap: Observable<Void>
        let endDateTap: Observable<Void>
    }
    
    struct Output {
        let depositTotal: Driver<String>
        let withdrawTotal: Driver<String>
    }
    
    let startTime: BehaviorRelay<String>
    let endTime: BehaviorRelay<String>
    
    override init() {
        let date = NSDate()
        startTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
        endTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
    }
    
    func transform(input: Input) -> Output {
        
        input.startDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: startTime).disposed(by: rx.disposeBag)
        
        input.endDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: endTime).disposed(by: rx.disposeBag)
        
        return Output(depositTotal: .just("0.00"), withdrawTotal: .just("0.00"))
    }
}
