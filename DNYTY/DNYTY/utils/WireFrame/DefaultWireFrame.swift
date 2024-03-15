//
//  DefaultWireFrame.swift
//  NEW
//
//  Created by WL on 2021/12/31.
//

import UIKit
import RxSwift
import PGDatePicker

protocol WireFrame {
    /// 弹框
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - cancelAction: 取消按钮
    ///   - actions: 其他按钮数组
    ///   - animated: 是否带动画
    ///   - completion: 完成闭包
    static func promptFor<Action: CustomStringConvertible>(_ title: String, message: String, cancelAction: Action, actions: [Action]?, animated: Bool, completion: (() -> Void)?) -> Observable<Action>
    
    static func showPrompt(text: String)
}

class DefaultWireFrame: WireFrame {
    class var topViewController: UIViewController  {
        UIApplication.shared.currentWindow.rootViewController!.zk_top
    }
    
    class func promptFor<Action: CustomStringConvertible>(_ title: String, message: String, cancelAction: Action, actions: [Action]? = nil, animated: Bool = true, completion: (() -> Void)? = nil) -> Observable<Action> {
        return Observable.create({ (observer) -> Disposable in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: cancelAction.description, style: .cancel, handler: { (_) in
                observer.onNext(cancelAction)
            }))
            
            if let  actions = actions {
                for action in actions {
                    alert.addAction(UIAlertAction(title: action.description, style: .default, handler: { (_) in
                        observer.onNext(action)
                    }))
                }
            }
            
            DefaultWireFrame.topViewController.present(alert, animated: animated, completion: completion)
            
            return Disposables.create { [weak alert] in
                alert?.dismiss(animated: animated, completion: nil)
            }
        })
    }
    
    class func showPrompt(text: String) {
        UIApplication.appDeltegate.window?.showHUDMessage(text)
    }
    
    class func presetSelctData() -> Observable<DateComponents> {
        return Observable.create({ (observer) -> Disposable in
            let datePickerManager = PGDatePickManager()
            
    //        datePickerManager.isShadeBackgroud = true
            let datePicker = datePickerManager.datePicker!
            datePicker.datePickerMode = .date
            datePicker.selectedDate = { dateComponents in
                guard let dateComponents = dateComponents else {
                    return
                }
                observer.onNext(dateComponents)
            }
            DefaultWireFrame.topViewController.present(datePickerManager, animated: false, completion: nil)
            
            

            
            return Disposables.create { [weak datePickerManager] in
                datePickerManager?.dismiss(animated: false, completion: nil)
            }
        })
        
    }
    
    typealias Game = ZKHomeServer.Game
    class func presetGame(game: Game) -> Observable<Void> {
        
        return Observable.create{ (observer) -> Disposable in
            guard let url = URL(string: baseURLString + "/game/third/app?play_id=" + String(game.id)) else {
                DefaultWireFrame.showPrompt(text: "txt4".wlLocalized)
                observer.onNext(())
                return Disposables.create()
            }
            
            
            let vc = ZKGameWebViewController(gameURL: url)
            DefaultWireFrame.topViewController.present(vc, animated: true, completion: {
                observer.onNext(())
            })
            
            return Disposables.create{ vc.dismiss(animated: true, completion: nil) }

            
        }
        
    }
    
    class func showAlert1(content: String) -> Observable<Bool> {
        let vc = ZKAlertViewController(content: content)
        
        DefaultWireFrame.topViewController.present(vc, animated: true)
        
        return vc.rx.submitResult
    }
    
//    class func showPickerView(title: String, items: [String]) -> Observable<Int> {
//        return Observable.create { (observer) -> Disposable in
//            let pickerViewC = ZKPickerViewController(title: title, items: items) { index in
//                observer.onNext(index)
//            }
//            DefaultWireFrame.topViewController.present(pickerViewC, animated: true, completion: nil)
//
//            return Disposables.create { [weak pickerViewC] in
//                pickerViewC?.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//
//    class func showPromp(title: String, icon: UIImage? = nil, content: String, cancelText: String? = nil, confirmText: String? = nil) ->Observable<Int> {
//        return Observable.create { (observer) -> Disposable in
//            let vc = ZKPromptViewController(title: title, icon: icon, content: content, cancelText: cancelText, confirmText: confirmText) { index in
//                observer.onNext(index)
//            }
//            DefaultWireFrame.topViewController.present(vc, animated: true, completion: nil)
//
//            return Disposables.create { [weak vc] in
//                vc?.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//
//    class func showWarning(title: String = "gameAmount65".wlLocalized, content: String, cancelText: String? = nil, confirmText: String? = "gameAmount49".wlLocalized) ->Observable<Int> {
//        return Observable.create { (observer) -> Disposable in
//            let vc = ZKPromptViewController(title: title, icon: UIImage(named: "tanhao"), content: content, cancelText: cancelText, confirmText: confirmText) { index in
//                observer.onNext(index)
//            }
//            DefaultWireFrame.topViewController.present(vc, animated: true, completion: nil)
//
//            return Disposables.create { [weak vc] in
//                vc?.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
//
//    class func showSuccess(title: String = "gameAmount65".wlLocalized, content: String, cancelText: String? = nil, confirmText: String? = "gameAmount49".wlLocalized) ->Observable<Int> {
//        return Observable.create { (observer) -> Disposable in
//            let vc = ZKPromptViewController(title: title, icon: UIImage(named: "dagou"), content: content, cancelText: cancelText, confirmText: confirmText) { index in
//                observer.onNext(index)
//            }
//            DefaultWireFrame.topViewController.present(vc, animated: true, completion: nil)
//
//            return Disposables.create { [weak vc] in
//                vc?.dismiss(animated: true, completion: nil)
//            }
//        }
//    }
    
}
