//
//  UIViewController+extension.swift
//  GameCaacaya
//
//  Created by WL on 2021/12/16.
//

import Foundation
import RxSwift

//alert
extension UIViewController {
    func promptFor<Action: CustomStringConvertible>(title: String? = nil, message: String? = nil, cancelAction: Action, actions: [Action]? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> Observable<Int> {
            return Observable.create({ (observer) -> Disposable in
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: cancelAction.description, style: .cancel, handler: { (_) in
                    observer.onNext(0)
                }))
                
                if let  actions = actions {
                    for (index, action) in actions.enumerated() {
                        alert.addAction(UIAlertAction(title: action.description, style: .default, handler: { (_) in
                            observer.onNext(index + 1)
                        }))
                    }
                }
                
                self.present(alert, animated: animated, completion: nil)
                
                return Disposables.create { [weak alert] in
                    alert?.dismiss(animated: animated, completion: completion)
                }
            })
    }
    
    class func zk_top() -> UIViewController {
        
        return UIApplication.shared.currentWindow.rootViewController!.zk_top 
    }

    var zk_top: UIViewController {
        var viewC: UIViewController = self
        if let navigC = self as? UINavigationController, let topVC = navigC.visibleViewController {
            viewC = topVC.zk_top
        } else if let tabC = self as? UITabBarController, let topVC = tabC.selectedViewController {
            viewC = topVC.zk_top
        } else if let presentedViewController = presentedViewController {
            viewC = presentedViewController.zk_top
        }

        return viewC
    }
    
    
    

}


extension UIApplication {
    class var appDeltegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var currentWindow: UIWindow {
        if #available(iOS 15, *) {
            return UIApplication.shared.connectedScenes
                .filter{ $0.activationState == .foregroundActive  }
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })!.windows.first(where: \.isKeyWindow)!
        } else {
            return UIApplication.shared.windows.first(where: \.isKeyWindow)!
        }
    }
}

