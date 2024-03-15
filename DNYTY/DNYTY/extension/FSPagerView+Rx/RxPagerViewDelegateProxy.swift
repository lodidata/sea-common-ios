//
//  RxPagerViewDelegateProxy.swift
//  DNYTY
//
//  Created by WL on 2022/6/29
//  
//
    

import Foundation
import FSPagerView

/// For more information take a look at `DelegateProxyType`.
open class RxPagerViewDelegateProxy: DelegateProxy<FSPagerView, FSPagerViewDelegate>, DelegateProxyType, FSPagerViewDelegate {
    public static func currentDelegate(for object: FSPagerView) -> FSPagerViewDelegate? {
        object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: FSPagerViewDelegate?, to object: FSPagerView) {
        object.delegate = delegate
    }
    

    /// Typed parent object.
    public weak private(set) var pagerView: FSPagerView?


    /// - parameter collectionView: Parent object for delegate proxy.
    public init(pagerView: ParentObject) {
        self.pagerView = pagerView
        super.init(parentObject: pagerView, delegateProxy: RxPagerViewDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxPagerViewDelegateProxy(pagerView: $0) }
    }

    open override func setForwardToDelegate(_ delegate: DelegateProxy<FSPagerView, FSPagerViewDelegate>.Delegate?, retainDelegate: Bool) {
        super.setForwardToDelegate(delegate, retainDelegate: retainDelegate)
    }

}


