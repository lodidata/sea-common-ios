//
//  ZKViewModel.swift
//  ZKBaseSwiftProject
//
//  Created by WL on 2021/12/13.
//  Copyright © 2021 zk. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}



class ZKViewModel: NSObject {
    var page = 1

    let indicator = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    //let parsedError = PublishSubject<ApiError>()
    
    override init() {
        super.init()
        serverError.bind{ error in
            UIViewController.zk_top().showHUDMessage(error.localizedDescription)
        }.disposed(by: self.rx.disposeBag)
    }
    
    deinit {
        
    }
    
}
