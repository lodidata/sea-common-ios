//
//  FSPagerView+Rx.swift
//  DNYTY
//
//  Created by WL on 2022/6/29
//  
//
    

import Foundation
import RxCocoa
import RxSwift
import FSPagerView
extension Reactive where Base: FSPagerView {
    /**
    Binds sequences of elements to collection view items.
    
    - parameter source: Observable sequence of items.
    - parameter cellFactory: Transform between sequence elements and view cells.
    - returns: Disposable object that can be used to unbind.
     
     Example
    
         let items = Observable.just([
             1,
             2,
             3
         ])

         items
         .bind(to: collectionView.rx.items) { (collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NumberCell
             cell.value?.text = "\(element) @ \(row)"
             return cell
         }
         .disposed(by: disposeBag)
    */
    public func items<Sequence: Swift.Sequence, Source: ObservableType>
        (_ source: Source)
        -> (_ cellFactory: @escaping (FSPagerView, Int, Sequence.Element) -> FSPagerViewCell)
        -> Disposable where Source.Element == Sequence {
        return { cellFactory in
            let dataSource = RxPagerViewReactiveArrayDataSourceSequenceWrapper<Sequence>(cellFactory: cellFactory)
            return self.items(dataSource: dataSource)(source)
        }
        
    }
    
    /**
    Binds sequences of elements to collection view items.
    
    - parameter cellIdentifier: Identifier used to dequeue cells.
    - parameter source: Observable sequence of items.
    - parameter configureCell: Transform between sequence elements and view cells.
    - parameter cellType: Type of collection view cell.
    - returns: Disposable object that can be used to unbind.
     
     Example

         let items = Observable.just([
             1,
             2,
             3
         ])

         items
             .bind(to: collectionView.rx.items(cellIdentifier: "Cell", cellType: NumberCell.self)) { (row, element, cell) in
                cell.value?.text = "\(element) @ \(row)"
             }
             .disposed(by: disposeBag)
    */
    public func items<Sequence: Swift.Sequence, Cell: FSPagerViewCell, Source: ObservableType>
        (cellIdentifier: String, cellType: Cell.Type = Cell.self)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable where Source.Element == Sequence {
        return { source in
            return { configureCell in
                let dataSource = RxPagerViewReactiveArrayDataSourceSequenceWrapper<Sequence> { cv, i, item in
                    let cell = cv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, at: i) as! Cell
                    configureCell(i, item, cell)
                    return cell
                }
                    
                return self.items(dataSource: dataSource)(source)
            }
        }
    }

    
    /**
    Binds sequences of elements to collection view items using a custom reactive data used to perform the transformation.
    
    - parameter dataSource: Data source used to transform elements to view cells.
    - parameter source: Observable sequence of items.
    - returns: Disposable object that can be used to unbind.
     
     Example
     
         let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Double>>()

         let items = Observable.just([
             SectionModel(model: "First section", items: [
                 1.0,
                 2.0,
                 3.0
             ]),
             SectionModel(model: "Second section", items: [
                 1.0,
                 2.0,
                 3.0
             ]),
             SectionModel(model: "Third section", items: [
                 1.0,
                 2.0,
                 3.0
             ])
         ])

         dataSource.configureCell = { (dataSource, cv, indexPath, element) in
             let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NumberCell
             cell.value?.text = "\(element) @ row \(indexPath.row)"
             return cell
         }

         items
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    */
    public func items<
            DataSource: RxPagerViewDataSourceType & FSPagerViewDataSource,
            Source: ObservableType>
        (dataSource: DataSource)
        -> (_ source: Source)
        -> Disposable where DataSource.Element == Source.Element
          {
        return { source in
            // This is called for side effects only, and to make sure delegate proxy is in place when
            // data source is being bound.
            // This is needed because theoretically the data source subscription itself might
            // call `self.rx.delegate`. If that happens, it might cause weird side effects since
            // setting data source will set delegate, and UICollectionView might get into a weird state.
            // Therefore it's better to set delegate proxy first, just to be sure.
            _ = self.delegate
            // Strong reference is needed because data source is in use until result subscription is disposed
            return source.subscribeProxyDataSource(ofObject: self.base, dataSource: dataSource, retainDataSource: true) { [weak pagerView = self.base] (_: RxPagerViewDataSourceProxy, event) -> Void in
                guard let pagerView = pagerView else {
                    return
                }
                dataSource.pagerView(pagerView, observedEvent: event)
            }
        }
    }

}


extension Reactive where Base: FSPagerView {
    public var delegate: DelegateProxy<FSPagerView, FSPagerViewDelegate> {
        return RxPagerViewDelegateProxy.proxy(for: base)
    }
    
    /// Reactive wrapper for `dataSource`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    public var dataSource: DelegateProxy<FSPagerView, FSPagerViewDataSource> {
        RxPagerViewDataSourceProxy.proxy(for: base)
    }
    
    /// Installs data source as forwarding delegate on `rx.dataSource`.
    /// Data source won't be retained.
    ///
    /// It enables using normal delegate mechanism with reactive delegate mechanism.
    ///
    /// - parameter dataSource: Data source object.
    /// - returns: Disposable object that can be used to unbind the data source.
    public func setDataSource(_ dataSource: FSPagerViewDataSource)
        -> Disposable {
            RxPagerViewDataSourceProxy.installForwardDelegate(dataSource, retainDelegate: false, onProxyForObject: self.base)
    }
    
    public func setDelegate(_ dataSource: FSPagerViewDelegate)
        -> Disposable {
            RxPagerViewDelegateProxy.installForwardDelegate(dataSource, retainDelegate: false, onProxyForObject: self.base)
    }
   
    /// Reactive wrapper for `delegate` message `collectionView(_:didSelectItemAtIndexPath:)`.
    public var itemSelected: ControlEvent<Int> {
        let source = delegate.methodInvoked(#selector(FSPagerViewDelegate.pagerView(_:didSelectItemAt:)))
            .map { a in
                return try castOrThrow(Int.self, a[1])
            }
        
        return ControlEvent(events: source)
    }

    var itemScrolled: ControlEvent<Int> {
        let source = observe(Int.self, "currentIndex").unwrap()
        return ControlEvent(events: source)
    }
    
}





extension ObservableType {
    func subscribeProxyDataSource<DelegateProxy: DelegateProxyType>(ofObject object: DelegateProxy.ParentObject, dataSource: DelegateProxy.Delegate, retainDataSource: Bool, binding: @escaping (DelegateProxy, Event<Element>) -> Void)
        -> Disposable
        where DelegateProxy.ParentObject: UIView
        , DelegateProxy.Delegate: AnyObject {
        let proxy = DelegateProxy.proxy(for: object)
        let unregisterDelegate = DelegateProxy.installForwardDelegate(dataSource, retainDelegate: retainDataSource, onProxyForObject: object)

        // Do not perform layoutIfNeeded if the object is still not in the view hierarchy
        if object.window != nil {
            // this is needed to flush any delayed old state (https://github.com/RxSwiftCommunity/RxDataSources/pull/75)
            object.layoutIfNeeded()
        }

        let subscription = self.asObservable()
            .observe(on:MainScheduler())
            .catch { error in
                bindingError(error)
                return Observable.empty()
            }
            // source can never end, otherwise it would release the subscriber, and deallocate the data source
            .concat(Observable.never())
            .take(until: object.rx.deallocated)
            .subscribe { [weak object] (event: Event<Element>) in

                if let object = object {
                    assert(proxy === DelegateProxy.currentDelegate(for: object), "Proxy changed from the time it was first set.\nOriginal: \(proxy)\nExisting: \(String(describing: DelegateProxy.currentDelegate(for: object)))")
                }
                
                binding(proxy, event)
                
                switch event {
                case .error(let error):
                    bindingError(error)
                    unregisterDelegate.dispose()
                case .completed:
                    unregisterDelegate.dispose()
                default:
                    break
                }
            }
            
        return Disposables.create { [weak object] in
            subscription.dispose()

            if object?.window != nil {
                object?.layoutIfNeeded()
            }

            unregisterDelegate.dispose()
        }
    }
    
    func bindingError(_ error: Swift.Error) {
        let error = "Binding error: \(error)"
    #if DEBUG
        rxFatalError(error)
    #else
        print(error)
    #endif
    }
}
