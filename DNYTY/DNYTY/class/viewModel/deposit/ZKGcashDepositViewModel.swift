//
//  ZKGcashDepositViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKGcashDepositViewModel: ZKViewModel, ViewModelType {
    typealias PayChannel = ZKWalletServer.PayChannel
    struct Input {
        
    }
    
    struct Output {
        let reloadIndexPath: Driver<IndexPath>
        let channels: Driver<[SectionModel<String, ZKGcashDepositCellViewModel>]>
        let payResult: Driver<ZKServerResult<URL?>>
    }
    let server = ZKWalletServer()

    func transform(input: Input) -> Output {
        let server = self.server
        let userServer = ZKUserServer()
        let indicator = self.indicator
        
        let channels = server.payTypeList().trackActivity(indicator).share()
        
        //金额列表选择
        let moneyList = ZKShareManager.shared.config.unwrap().merge(with: userServer.startConfig()).map{ $0.rechargeMoneyList.map { money in
            (money/100).stringValue
        } }
        
        let channelsViewModels = Observable.combineLatest(moneyList, channels) { moneyList, channels in
            channels.map{ ZKGcashDepositCellViewModel(channel: $0, moneyList: moneyList) }
        }.share()
        
        let channelsOutput = channelsViewModels.map{ [SectionModel(model: "", items: $0)] }.asDriver(onErrorJustReturn: [])
        
        let reloadIndexPath = channelsViewModels.flatMap{ viewModels -> Observable<IndexPath> in
            var reloadIndexPathList: [Observable<IndexPath>] = []
            for (i, viewModel) in viewModels.enumerated() {
                reloadIndexPathList.append(viewModel.isShow.map{ _ in IndexPath(item: i, section: 0) }.skip(1))
            }
            
            return Observable.from(reloadIndexPathList).merge()
        }.asDriverOnErrorJustComplete()
        
        let payResult = channelsViewModels.flatMap { viewModels -> Observable<(PayChannel, String)> in
            var submitTaps: [Observable<(PayChannel, String)>] = []
            for viewModel in viewModels {
                submitTaps.append(viewModel.submitTap.asObservable())
            }
            return Observable.from(submitTaps).merge()
        }.flatMapLatest{ channel, money -> Observable<ZKServerResult<URL?>> in
            guard let moneyNumber = Double(money) else {
                return .just(.failed(message: "new9".wlLocalized))
            }
            
            if moneyNumber < channel.minMoney/100 {
                return .just(.failed(message: "errorTxt7".wlLocalized + " " + (channel.minMoney/100).stringValue))
            }
            
            if moneyNumber > channel.maxMoney/100 {
                return .just(.failed(message: "errorTxt17".wlLocalized + " " + (channel.maxMoney/100).stringValue))
            }
            
            return server.rechargeOnlines(payId: channel.id, money: money).trackActivity(indicator)
        }.asDriver(onErrorJustReturn: .failed(message: "error"))
        
        
        return Output(reloadIndexPath: reloadIndexPath, channels: channelsOutput, payResult: payResult)
    }
}
