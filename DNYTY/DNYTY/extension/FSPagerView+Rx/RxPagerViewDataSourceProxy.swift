//
//  RxFSPagerViewDataSourceProxy.swift
//  DNYTY
//
//  Created by WL on 2022/6/29
//  
//
    

import UIKit

import UIKit
import RxSwift
import RxCocoa
import FSPagerView

func rxAbstractMethod(message: String = "Abstract method", file: StaticString = #file, line: UInt = #line) -> Swift.Never {
    rxFatalError(message, file: file, line: line)
}

func rxFatalError(_ lastMessage: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Swift.Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage(), file: file, line: line)
}

let dataSourceNotSet = "DataSource not set"

extension FSPagerView: HasDataSource {
    public typealias DataSource = FSPagerViewDataSource
}

private let pagerViewDataSourceNotSet = FSPagerViewDataSourceNotSet()

private final class FSPagerViewDataSourceNotSet
    : NSObject
, FSPagerViewDataSource {

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        0
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        rxAbstractMethod(message: dataSourceNotSet)
        fatalError()
    }


}

/// For more information take a look at `DelegateProxyType`.
open class RxPagerViewDataSourceProxy
    : DelegateProxy<FSPagerView, FSPagerViewDataSource>
    , DelegateProxyType {

    /// Typed parent object.
    public weak private(set) var pagerView: FSPagerView?

    /// - parameter collectionView: Parent object for delegate proxy.
    public init(pagerView: ParentObject) {
        self.pagerView = pagerView
        super.init(parentObject: pagerView, delegateProxy: RxPagerViewDataSourceProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxPagerViewDataSourceProxy(pagerView: $0) }
    }

    private weak var _requiredMethodsDataSource: FSPagerViewDataSource? = pagerViewDataSourceNotSet

    /// For more information take a look at `DelegateProxyType`.
    open override func setForwardToDelegate(_ forwardToDelegate: FSPagerViewDataSource?, retainDelegate: Bool) {
        _requiredMethodsDataSource = forwardToDelegate ?? pagerViewDataSourceNotSet
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
    }
}

extension RxPagerViewDataSourceProxy: FSPagerViewDataSource {
    /// Required delegate method implementation.
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        (_requiredMethodsDataSource ?? pagerViewDataSourceNotSet).numberOfItems(in: pagerView)
    }


    /// Required delegate method implementation.
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        (_requiredMethodsDataSource ?? pagerViewDataSourceNotSet).pagerView(pagerView, cellForItemAt: index)
    }

}


public protocol RxPagerViewDataSourceType /*: UICollectionViewDataSource*/ {
    
    /// Type of elements that can be bound to collection view.
    associatedtype Element
    
    /// New observable sequence event observed.
    ///
    /// - parameter collectionView: Bound collection view.
    /// - parameter observedEvent: Event
    func pagerView(_ pagerView: FSPagerView, observedEvent: Event<Element>)
}
