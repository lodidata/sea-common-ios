//
//  RxActivityIndicator.swift
//  GameCaacaya
//
//  Created by WL on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa

/// 活动指示器
class ActivityIndicator: SharedSequenceConvertibleType {
    typealias Element = Bool
    typealias SharingStrategy = DriverSharingStrategy
    
    /// 锁
    let lock = NSRecursiveLock()
    /// 计数序列
    let relay = BehaviorRelay(value: 0)
    /// 加载序列
    let loading: SharedSequence<SharingStrategy, Bool>
    
    init() {
        loading = relay.asDriver().map({ $0 > 0 }).distinctUntilChanged()
    }
    
    /// 增量计数
    func increment() {
        lock.lock()
        relay.accept(relay.value + 1)
        lock.unlock()
    }
    /// 减量计数
    func decrement() {
        lock.lock()
        relay.accept(relay.value - 1)
        lock.unlock()
    }
    
    /// 跟踪活动
    /// - Parameter source: 源序列
    func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ [weak self] () -> ActivityToken<Source.Element> in
            // 增量计数
            self?.increment()
            // 返回一个Disposable
            return ActivityToken(source: source.asObservable(), disposeAction: self?.decrement ?? {})
        }, observableFactory: { (t) in
            // 返回一个序列
            t.asObservable()
        })
    }
    
    /// 遵守协议
    func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Bool> {
        return loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ indicator: ActivityIndicator) -> Observable<Element> {
        return indicator.trackActivityOfObservable(self)
    }
    
}
