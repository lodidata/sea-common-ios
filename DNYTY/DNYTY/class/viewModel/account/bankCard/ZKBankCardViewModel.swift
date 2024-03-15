//
//  ZKBankCardViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/21
//  
//
    

import UIKit
import RxCocoa
import ObjectMapper

class ZKBankCardViewModel: ZKViewModel, ViewModelType {
    typealias Card = ZKWalletServer.BindCardInfo

    struct Input {
        let viewWillShow: Observable<Void>
    }
    
    struct Output {
        let cardList: Driver<[SectionModel<String, ZKBankCardCellViewModel>]>
        let deleteResult: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let server = ZKWalletServer()
        
        let cardList: BehaviorRelay<[ZKBankCardCellViewModel]> = BehaviorRelay(value: [])
        
        input.viewWillShow.flatMap{ server.getBindBankList().trackActivity(self.indicator) }.map{
            $0.map { ZKBankCardCellViewModel(card: $0)}
        }.bind(to: cardList).disposed(by: rx.disposeBag)
        
        
        //删除
        let deleteReuslt = cardList.flatMap{ vmList -> Observable<Card> in
            let deletes = vmList.map { vm in
                vm.deleteTap.map{ vm.card }
            }
            
            return Observable.from(deletes).merge()
        }.flatMapLatest{ card in
            DefaultWireFrame.showAlert1(content: "card18".wlLocalized).filter{ $0 }.map{ _ in card.id }
        }.flatMap{ id in
            server.deleteCard(id: id).trackActivity(self.indicator)
        }.share()
        let deleteReusltOutput = deleteReuslt.asDriver(onErrorJustReturn: "")
        
        //删除后刷新列表
        deleteReuslt.flatMap{ _ in server.getBindBankList().trackActivity(self.indicator).map{
            $0.map { ZKBankCardCellViewModel(card: $0)}
        } }.bind(to: cardList).disposed(by: rx.disposeBag)
        
        let cardListOutput = cardList.map{ $0.map{ SectionModel(model: "", items: [$0]) } }.asDriver(onErrorJustReturn: [])
        
        return Output(cardList: cardListOutput, deleteResult: deleteReusltOutput)
    }
}
