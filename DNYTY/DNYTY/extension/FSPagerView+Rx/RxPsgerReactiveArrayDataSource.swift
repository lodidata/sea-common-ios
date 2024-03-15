//
//  RxPsgerReactiveArrayDataSource.swift
//  DNYTY
//
//  Created by WL on 2022/6/29
//  
//
    

import Foundation
import FSPagerView

class _RxPagerViewReactiveArrayDataSource: NSObject, FSPagerViewDataSource {
    
    
    fileprivate func _pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        fatalError("Abstract method", file: #file, line: #line)
    }
    
    
    fileprivate func _numberOfItems(in pagerView: FSPagerView) -> Int {
        0
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        _numberOfItems(in: pagerView)
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        _pagerView(pagerView, cellForItemAt: index)
    }

}

class RxPagerViewReactiveArrayDataSourceSequenceWrapper<Sequence: Swift.Sequence>
    : RxPagerViewReactiveArrayDataSource<Sequence.Element>
, RxPagerViewDataSourceType {
    
    
    typealias Element = Sequence

    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
    }
        
    func pagerView(_ pagerView: FSPagerView, observedEvent: Event<Sequence>) {
        Binder(self) { pagerDataSource, sectionModels in
            let sections = Array(sectionModels)
            pagerDataSource.pagerView(pagerView, observedElements: sections)
        }.on(observedEvent)
    }
    
}


// Please take a look at `DelegateProxyType.swift`
class RxPagerViewReactiveArrayDataSource<Element>
    : _RxPagerViewReactiveArrayDataSource
    , SectionedViewDataSourceType {
    
    typealias CellFactory = (FSPagerView, Int, Element) -> FSPagerViewCell
    
    var itemModels: [Element]?
    
    func modelAtIndex(_ index: Int) -> Element? {
        itemModels?[index]
    }

    func model(at indexPath: IndexPath) throws -> Any {
        precondition(indexPath.section == 0)
        guard let item = itemModels?[indexPath.item] else {
            throw RxCocoaError.itemsNotYetBound(object: self)
        }
        return item
    }
    
    var cellFactory: CellFactory
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    // data source
        
    override func _numberOfItems(in pagerView: FSPagerView) -> Int {
        itemModels?.count ?? 0
    }
    
    override func _pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        cellFactory(pagerView, index, itemModels![index])
    }
    
    
    // reactive
        
    
    
    func pagerView(_ pagerView: FSPagerView, observedElements: [Element]) {
        self.itemModels = observedElements
        
        pagerView.reloadData()

        
    }
}
