//
//  ZKDepositRecord2ViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit
import Rswift

class ZKDepositRecord2ViewModel: ZKViewModel, ViewModelType {
    
    enum SearchType {
        case deposit
        case withdraw
        var title: String {
            switch self {
            case .deposit:
                return "finance15".wlLocalized
            case .withdraw:
                return "finance17".wlLocalized
            }
        }
    }

  
    struct Input {
        let headerRefresh: Observable<Void> //刷新记录
        let loadMore: Observable<Void>
        let startDateTap: Observable<Void>
        let endDateTap: Observable<Void>
        let searchTap: Observable<Void>
    }
    
    struct Output {
        let recordList: Driver<[SectionModel<String, DepositRecordCellViewModel>]>
        let time: Driver<String>
        let selectType: Driver<String>
        let hasData: Driver<Bool>
    }
    
    let recordList: BehaviorRelay<[DepositRecordCellViewModel]> = BehaviorRelay(value: [])
    let startTime: BehaviorRelay<String>
    let endTime: BehaviorRelay<String>
    
    let typeList: BehaviorRelay<[SearchType]> = BehaviorRelay(value: [.deposit, .withdraw])
    let selectType: BehaviorRelay<SearchType> = BehaviorRelay(value: .deposit)
    
   
    
    struct DepositRecordCellViewModel {
        let title: String
        let time: String
        let money: String
        let tradeNo: String
    }
    
    override init() {
        let date = NSDate()
        
        startTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
        endTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
    }
    let server = ZKWalletServer()
    func transform(input: Input) -> Output {
    
        
        let scan = Observable.combineLatest(selectType, startTime, endTime)
        
        let searchList = input.searchTap.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [DepositRecordCellViewModel])> in
            self.page = 1
            return self.requestList(type: type, start: start, end: end, page: self.page).trackActivity(self.indicator)
        }.share()
        
        let headerRefresh = input.headerRefresh.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [DepositRecordCellViewModel])> in
            self.page = 1
            return self.requestList(type: type, start: start, end: end, page: self.page).trackActivity(self.headerLoading)
        }.share()
        
        let loadMordList = input.loadMore.withLatestFrom(scan).flatMapLatest{ type, start, end -> Observable<(page: Int, total: Int, data: [DepositRecordCellViewModel])> in
            self.page += 1
            return self.requestList(type: type, start: start, end: end, page: self.page).trackActivity(self.footerLoading)
        }.withLatestFrom(recordList) { resp, list in
            (page: resp.page, total: resp.total, data: list + resp.data)
        }.share()
        
        let capitalList = Observable.of(searchList, headerRefresh, loadMordList).merge()
        
        capitalList.map{ $0.data }.bind(to: recordList).disposed(by: rx.disposeBag)
        
        let recordListOutput = capitalList.map { page, total, data in
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
        
        let selectType = selectType.map{ $0.title }.asDriver(onErrorJustReturn: "")
        
        let hasDate = capitalList.map{ $0.data.count > 0 }.asDriver(onErrorJustReturn: false)
        
        return Output(recordList: recordListOutput, time: timeOutput, selectType: selectType, hasData: hasDate)
    }
    
    func requestList(type: SearchType, start: String, end: String, page: Int) -> Observable<(page: Int, total: Int, data: [DepositRecordCellViewModel])> {
        switch type {
        case .deposit:
            return self.server.getDepositList(strat: start, end: end, page: page).map { (page: Int, total: Int, data: [ZKWalletServer.DepositModel]) in
                return (page: page, total: total, data: data.map{ depositMode in
                    DepositRecordCellViewModel(title: type.title, time: depositMode.time, money: (depositMode.money/100).stringValue, tradeNo: depositMode.tradeNo)
                })
            }
        case .withdraw:
            return self.server.getWithdrawList(strat: start, end: end, page: page).map { (page: Int, total: Int, data: [ZKWalletServer.WithdrawModel]) in
                return (page: page, total: total, data: data.map{ withdrawMode in
                    DepositRecordCellViewModel(title: type.title, time: withdrawMode.time, money: (withdrawMode.money/100).stringValue, tradeNo: withdrawMode.tradeNo)
                })
            }
        }
    }
}
