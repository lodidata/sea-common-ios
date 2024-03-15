//
//  SDCycleScrollView+Rx.swift
//  NEW
//
//  Created by WL on 2022/1/13.
//

import Foundation
import SDCycleScrollView
import RxCocoa
import RxSwift

extension Reactive where Base: SDCycleScrollView {
    var imageURLStringsGroup: Binder<[String]> {
        Binder(self.base) { cycleScollView, urlStrings in
            cycleScollView.imageURLStringsGroup = urlStrings
        }
    }
}
