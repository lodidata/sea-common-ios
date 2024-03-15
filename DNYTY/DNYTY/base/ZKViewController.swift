//
//  ZKBaseViewController.swift
//  ZKBaseSwiftProject
//
//  Created by WL on 2021/12/13.
//  Copyright © 2021 zk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import MBProgressHUD
protocol ZKViewControllerType {
    func initSubView()
    func layoutSubView()
    func bindViewModel()
}

class ZKViewController: UIViewController, ZKViewControllerType, Navigatable {
    
    var viewModel: ZKViewModel!
    var navigator: Navigator {
        Navigator.default
    }

    convenience init(viewModel: ZKViewModel? = nil) {
        self.init()
        self.viewModel = viewModel
    }
    
   

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        rx.methodInvoked(#selector(UIViewController.viewDidLoad)).bind {  [unowned self] _ in
            self.initSubView()
            self.layoutSubView()
            self.bindViewModel()
        }.disposed(by: rx.disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        rx.methodInvoked(#selector(UIViewController.viewDidLoad)).bind {  [unowned self] _ in
            self.initSubView()
            self.layoutSubView()
            self.bindViewModel()
        }.disposed(by: rx.disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal

            //去掉返回菜单
            let backItem = ZKBackBarButtonItem(title: "", style: .plain, target: self, action: nil)
            navigationItem.backBarButtonItem = backItem
        } else if #available(iOS 13.0, *) {

            navigationItem.backButtonTitle = ""
        } else {
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
        }

        
    }
    
    
    
    
    func initSubView() {
        
    }
    
    func layoutSubView() {
        
    }
    
    func bindViewModel() {
        
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    
    override var shouldAutorotate: Bool {
        false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
}

extension Reactive where Base: ZKViewController {
    var promptText: Binder<String> {
        return Binder(base){ vc, text in
            vc.showHUDMessage(text)
        }
    }
    
    var hud: Binder<String> {
        return Binder(base){ vc, text in
            if text.isEmpty {
                vc.hideHUD()
            } else {
                vc.showHUD(withMessage: text)
            }
            
        }
    }
    
    var loading: Binder<Bool> {
        return Binder(base){ vc, isLoading in
            if isLoading {
                //ZKGameLoadingView.show()
                //vc.showHUD()
                
                ZKHudLoadingFrame.show()
            } else {
                ZKHudLoadingFrame.hide()
                //vc.hideHUD()
                //ZKGameLoadingView.hide()
            }
        }
    }
}



// MARK: Navigatable

