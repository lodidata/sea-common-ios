//
//  ZKShareManager.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit
import RxRelay

class ZKShareManager: NSObject {

    typealias Config = ZKUserServer.Config
    typealias Wallet = ZKWalletServer.Wallet
    typealias UserInfo = ZKUserServer.UserInfo
    
    static let shared = ZKShareManager()
    let config: BehaviorRelay<Config?> = BehaviorRelay(value: nil)
    let wallet: BehaviorRelay<Wallet?> = BehaviorRelay(value: nil)
    let userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
    
    
    
    
}
