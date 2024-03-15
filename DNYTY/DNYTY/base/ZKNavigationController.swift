//
//  ZKNavigationController.swift
//  GameCaacaya
//
//  Created by WL on 2021/12/21.
//

import UIKit
import RxSwift
class ZKNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        rx.willShow.bind {[weak self] vc, _ in
            guard let self = self, let tabBarController = self.tabBarController as? ZKHomeTabBarController else { return  }
            tabBarController.kefuBtn.isHidden = vc.classForCoder == ZKH5ViewController.self
            
        }.disposed(by: rx.disposeBag)
        
    }
    
    

    override var shouldAutorotate: Bool {
        topViewController?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        topViewController?.prefersStatusBarHidden ?? false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle  ?? .default
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZKNavigationController{
    override func pushViewController(_ viewController: UIViewController,animated: Bool){
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}



