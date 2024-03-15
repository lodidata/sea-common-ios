//
//  ZKApplysViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKApplysViewModel: ZKViewModel, ViewModelType {

//    enum SearchType {
//        case deposit
//        case withdraw
//        var title: String {
//            switch self {
//            case .deposit:
//                return "存款"
//            case .withdraw:
//                return "取款"
//            }
//        }
//    }

    typealias ApplyModel = ZKWalletServer.ApplyModel
    struct Input {
        let headerRefresh: Observable<Void> //刷新记录
        let loadMore: Observable<Void>
        let startDateTap: Observable<Void>
        let endDateTap: Observable<Void>
        let searchTap: Observable<Void>
    }
    
    struct Output {
        let recordList: Driver<[SectionModel<String, ApplyModel>]>
//        let time: Driver<String>
//        let selectType: Driver<String>
        let hasData: Driver<Bool>
    }
    
    let recordList: BehaviorRelay<[ApplyModel]> = BehaviorRelay(value: [])
    let startTime: BehaviorRelay<String>
    let endTime: BehaviorRelay<String>
    
//    let typeList: BehaviorRelay<[SearchType]> = BehaviorRelay(value: [.deposit, .withdraw])
//    let selectType: BehaviorRelay<SearchType> = BehaviorRelay(value: .deposit)
    
   
    
//    struct DepositRecordCellViewModel {
//        let title: String
//        let time: String
//        let money: String
//        let tradeNo: String
//    }
    
    override init() {
        let date = NSDate()

        startTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
        endTime = BehaviorRelay(value: date.string(withFormat: "yyyy-MM-dd") ?? "")
    }
    let server = ZKWalletServer()
    func transform(input: Input) -> Output {
    
        
        let scan = Observable.combineLatest(startTime, endTime)
        
        let searchList = input.searchTap.withLatestFrom(scan).flatMapLatest{ start, end -> Observable<(page: Int, total: Int, data: [ApplyModel])> in
            self.page = 1
            return self.server.getApplyList(page: self.page).trackActivity(self.indicator)
        }.share()
        
        let headerRefresh = input.headerRefresh.withLatestFrom(scan).flatMapLatest{ start, end -> Observable<(page: Int, total: Int, data: [ApplyModel])> in
            self.page = 1
            return self.server.getApplyList(page: self.page).trackActivity(self.headerLoading)
        }.share()
        
        let loadMordList = input.loadMore.flatMapLatest{ () -> Observable<(page: Int, total: Int, data: [ApplyModel])> in
            self.page += 1
            return self.server.getApplyList(page: self.page).trackActivity(self.footerLoading)
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
        
//        let timeOutput = scan.map{ _, start, end in
//            start + "~" + end
//        }.startWith("").asDriver(onErrorJustReturn: "")
//
//        let selectType = selectType.map{ $0.title }.asDriver(onErrorJustReturn: "")
        
        let hasDate = capitalList.map{ $0.data.count > 0 }.asDriver(onErrorJustReturn: false)
        
        return Output(recordList: recordListOutput, hasData: hasDate)
    }
    
    
}
