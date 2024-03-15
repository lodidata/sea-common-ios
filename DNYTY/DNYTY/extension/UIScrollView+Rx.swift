//
//  UIScrollView+Rx.swift
//  DNYTY
//
//  Created by WL on 2022/6/20
//  
//
    

import Foundation

extension Reactive where Base: UIScrollView {
    var currentIndex: Observable<Int> {
        self.base.rx.didEndDecelerating.map{ _ in self.zk_pageIndex }.asObservable()
    }
    
    private var zk_pageIndex: Int {
        Int(self.base.contentOffset.x/self.base.width)
    }
}
