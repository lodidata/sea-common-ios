//
//  ZKHudLoaddingFrame.swift
//  DNYTY
//
//  Created by WL on 2022/6/24
//  
//
    

import UIKit

class ZKHudLoadingFrame: NSObject {
    static var `default` = ZKHudLoadingFrame()
    
    private let loading = ZKLoadingView()
    
    var loadingView: ZKLoadingView  {
        guard let window = UIApplication.appDeltegate.window else { return loading }
        window.addSubview(loading)
        window.bringSubviewToFront(loading)
        loading.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return loading
    }
    
    private override init() {
        super.init()
        
        
        relay.bind { [weak self] i in
            guard let self = self else { return  }
            self.loadingView.isHidden = i == 0
        }.disposed(by: rx.disposeBag)
        
        
        
    }
    
    //超时时间
    //let timeout = 120
    /// 锁
    let lock = NSRecursiveLock()
    /// 计数序列
    let relay = BehaviorRelay(value: 0)
    /// 增量计数
    func increment() {
        lock.lock()
        relay.accept(relay.value + 1)
        lock.unlock()
    }
    /// 减量计数
    func decrement() {
        lock.lock()
        if relay.value != 0 {
            relay.accept(relay.value - 1)
        }
        
        lock.unlock()
    }
    
    class func show() {
        self.default.increment()
    }
    
    class func hide() {
        self.default.decrement()
    }
}
