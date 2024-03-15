//
//  ActivityToken.swift
//  GameCaacaya
//
//  Created by WL on 2021/12/17.
//
import RxSwift
import Foundation

/// 活动令牌
struct ActivityToken<E>: ObservableConvertibleType, Disposable {
    let _source: Observable<E>
    let _dispose: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }
    func asObservable() -> Observable<E> {
        return _source
    }
    
    func dispose() {
        _dispose.dispose()
    }
}
