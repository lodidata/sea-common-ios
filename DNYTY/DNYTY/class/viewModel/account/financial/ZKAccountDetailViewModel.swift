//
//  ZKAccountDetailViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit
import RxRelay

class ZKAccountDetailViewModel: ZKViewModel, ViewModelType {

    typealias CapitalType = ZKWalletServer.CapitalType
    typealias CapitalModel = ZKWalletServer.CapitalModel
    struct Input {
        let headerRefresh: Observable<Void> //刷新记录
        let loadMore: Observable<Void>
        let startDateTap: Observable<Void>
        let endDateTap: Observable<Void>
        let searchTap: Observable<Void>
    }
    
    struct Output {
        let capitalList: Driver<[SectionModel<String, CapitalModel>]>
        let time: Driver<String>
        let selectType: Driver<String>
        let hasData: Driver<Bool>
    }
    
    let capitalList: BehaviorRelay<[CapitalModel]> = BehaviorRelay(value: [])
    let startTime: BehaviorRelay<String>
    let endTime: BehaviorRelay<String>
    
    
    
    let typeList: BehaviorRelay<[CapitalType]> = BehaviorRelay(value: [])
    let selectType: BehaviorRelay<CapitalType?> = BehaviorRelay(value: nil)
    
    override init() {
        let date = NSDate()
        
        startTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
        endTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
    }
    
    func transform(input: Input) -> Output {
        let server = ZKWalletServer()
        
        server.getCapitalTypeList().bind(to: typeList).disposed(by: rx.disposeBag)
        typeList.map{ $0.first }.bind(to: selectType).disposed(by: rx.disposeBag)
        
        let scan = Observable.combineLatest(selectType.unwrap(), startTime, endTime)
        
        let searchList = input.searchTap.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [CapitalModel])> in
            self.page = 1
            return server.getCapitalList(type: 0, gameType: type.id, start: start, end: end, page: self.page).trackActivity(self.indicator)
        }.share()
        
        let headerRefresh = input.headerRefresh.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [CapitalModel])> in
            self.page = 1
            return server.getCapitalList(type: 0, gameType: type.id, start: start, end: end, page: self.page).trackActivity(self.headerLoading)
        }.share()
        
        let loadMordList = input.loadMore.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [CapitalModel])> in
            self.page += 1
            return server.getCapitalList(type: 0, gameType: type.id, start: start, end: end, page: self.page).trackActivity(self.footerLoading)
        }.withLatestFrom(capitalList) { resp, list in
            (page: resp.page, total: resp.total, data: list + resp.data)
        }.share()
        
        let capitalList = Observable.of(searchList, headerRefresh, loadMordList).merge()
        
        capitalList.map{ $0.data }.bind(to: self.capitalList).disposed(by: rx.disposeBag)
        
        let depositListOutput = capitalList.map { page, total, data in
            [SectionModel(model: "", items: data)]
        }.asDriver(onErrorJustReturn: [])
        
        input.startDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: startTime).disposed(by: rx.disposeBag)
        
        input.endDateTap.flatMapLatest{ DefaultWireFrame.presetSelctData() }.map{ dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: endTime).disposed(by: rx.disposeBag)
        
        let timeOutput = scan.map{ _, start, end in
            start + "~" + end
        }.startWith("").asDriver(onErrorJustReturn: "")
        
        let selectType = selectType.unwrap().map{ $0.name }.asDriver(onErrorJustReturn: "")
        
        let hasDate = capitalList.map{ $0.data.count > 0 }.asDriver(onErrorJustReturn: false)
        
        return Output(capitalList: depositListOutput, time: timeOutput, selectType: selectType, hasData: hasDate)
    }
    
}
