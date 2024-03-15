//
//  ZKDepositRecordViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/20
//  
//
    

import UIKit
import RxRelay

class ZKDepositRecordViewModel: ZKViewModel, ViewModelType {

    typealias DepositModel = ZKWalletServer.DepositModel
    struct Input {
        let headerRefresh: Observable<Void> //刷新存款记录
        let loadMore: Observable<Void>
        let startDateTap: Observable<Void>
        let endDateTap: Observable<Void>
        let searchTap: Observable<Void>
    }
    
    struct Output {
        let depositList: Driver<[SectionModel<String, DepositModel>]>
        let time: Driver<String>
        let hasData: Driver<Bool>
    }
    
    let depositList: BehaviorRelay<[DepositModel]> = BehaviorRelay(value: [])
    let startTime: BehaviorRelay<String>
    let endTime: BehaviorRelay<String>
    
    let server = ZKWalletServer()
    
    override init() {
        let date = NSDate()
        startTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
        endTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
    }
    
    func transform(input: Input) -> Output {
        
        let time = Observable.combineLatest(startTime, endTime)
        
        let searchList = input.searchTap.withLatestFrom(time).flatMapLatest{ start, end -> Observable<(page: Int, total: Int, data: [DepositModel])> in
            self.page = 1
            return self.server.getDepositList(strat: start, end: end, page: self.page).trackActivity(self.indicator)
        }.share()
        
        let headerRefresh = input.headerRefresh.withLatestFrom(time).flatMapLatest{ startTime, endTime -> Observable<(page: Int, total: Int, data: [DepositModel])> in
            self.page = 1
            return self.server.getDepositList(strat: startTime, end: endTime, page: self.page).trackActivity(self.headerLoading)
        }.share()
        
        let loadMordList = input.loadMore.withLatestFrom(time).flatMapLatest{ startTime, endTime -> Observable<(page: Int, total: Int, data: [DepositModel])> in
            self.page += 1
            return self.server.getDepositList(strat: startTime, end: endTime, page: self.page).trackActivity(self.footerLoading)
        }.withLatestFrom(depositList) { resp, list in
            (page: resp.page, total: resp.total, data: list + resp.data)
        }.share()
        
        let depositList = Observable.of(searchList, headerRefresh, loadMordList).merge()
        
        depositList.map{ $0.data }.bind(to: self.depositList).disposed(by: rx.disposeBag)
        
        let depositListOutput = depositList.map { page, total, data in
            [SectionModel(model: "", items: data)]
        }.asDriver(onErrorJustReturn: [])
        
        input.startDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: startTime).disposed(by: rx.disposeBag)
        
        input.endDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: endTime).disposed(by: rx.disposeBag)
        
        let timeOutput = time.map{ start, end in
            start + "~" + end
        }.startWith("").asDriver(onErrorJustReturn: "")
        let hasDate = depositList.map{ $0.data.count > 0 }.asDriver(onErrorJustReturn: false)
        return Output(depositList: depositListOutput, time: timeOutput, hasData: hasDate)
    }
    
}
