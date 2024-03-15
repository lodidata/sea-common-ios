//
//  ZKCardDepositViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKCardDepositViewModel: ZKViewModel, ViewModelType {
    typealias PayChannel = ZKWalletServer.PayChannel
    typealias Bank = ZKCardDepositCellViewModel.Bank
    struct Input {
        
    }
    
    struct Output {
        let reloadIndexPath: Driver<IndexPath>
        let channels: Driver<[SectionModel<String, ZKCardDepositCellViewModel>]>
        let payResult: Driver<ZKServerResult<URL?>>
    }
    let server = ZKWalletServer()

    func transform(input: Input) -> Output {
        let server = self.server
        let indicator = self.indicator
        
        let channels = server.payTypeList().trackActivity(indicator).map{ $0.filter{ $0.id == 2 } }.share()
        
        let channelsViewModels = channels.map { channels in
            channels.map{ ZKCardDepositCellViewModel(channel: $0) }
        }.share()
        
        let channelsOutput = channelsViewModels.map{ [SectionModel(model: "", items: $0)] }.asDriver(onErrorJustReturn: [])
        
        let reloadIndexPath = channelsViewModels.flatMap{ viewModels -> Observable<IndexPath> in
            var reloadIndexPathList: [Observable<IndexPath>] = []
            for (i, viewModel) in viewModels.enumerated() {
                reloadIndexPathList.append(viewModel.isShow.map{ _ in IndexPath(item: i, section: 0) }.skip(1))
            }
            
            return Observable.from(reloadIndexPathList).merge()
        }.asDriverOnErrorJustComplete()
        
        let payResult = channelsViewModels.flatMap { viewModels -> Observable<(PayChannel, Bank, String)> in
            var submitTaps: [Observable<(PayChannel, Bank, String)>] = []
            for viewModel in viewModels {
                let para = viewModel.submitTap.map { money -> (PayChannel, Bank, String) in
                    (viewModel.channel, viewModel.bankList[viewModel.selectBankIndex.value], money)
                }
                
                submitTaps.append(para)
            }
            return Observable.from(submitTaps).merge()
        }.flatMapLatest{ channel, bank, money -> Observable<ZKServerResult<URL?>> in
            guard let moneyNumber = Double(money) else {
                return .just(.failed(message: "new9".wlLocalized))
            }
            
            if moneyNumber < channel.minMoney/100 {
                return .just(.failed(message: "errorTxt7".wlLocalized + " " + (channel.minMoney/100).stringValue))
            }
            
            if moneyNumber > channel.maxMoney/100 {
                return .just(.failed(message: "errorTxt8".wlLocalized + " " + (channel.maxMoney/100).stringValue))
            }
            
            return server.rechargeOnlines(payId: channel.id, bankData: bank.value, money: money).trackActivity(indicator)
        }.asDriver(onErrorJustReturn: .failed(message: "error"))
        
        
        return Output(reloadIndexPath: reloadIndexPath, channels: channelsOutput, payResult: payResult)
    }
}
