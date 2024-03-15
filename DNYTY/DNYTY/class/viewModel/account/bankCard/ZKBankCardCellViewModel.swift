//
//  ZKBankCardCellViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/22
//  
//
    

import UIKit

class ZKBankCardCellViewModel: ZKViewModel {

    typealias Card = ZKWalletServer.BindCardInfo
    let card: Card
    
    let bank: String
    let name: String
    let account: String
    let deleteTap: PublishRelay<Void> = PublishRelay()
    
    
    init(card: Card) {
        self.card = card
        bank = card.bankName
        name = card.name
        account = card.account
    }
    
}
