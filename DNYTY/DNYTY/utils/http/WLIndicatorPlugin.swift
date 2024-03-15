//
//  WLIndicatorPlugin.swift
//  NEW
//
//  Created by wulin on 2022/1/7.
//

import UIKit
import Moya
import SwiftyJSON
import RxSwift

class WLIndicatorPlugin: PluginType {

    //最顶层的视图控制器
    private var viewController: UIViewController {
        return UIApplication.appDeltegate.window!.rootViewController!.zk_top
    }
     
    //活动状态指示器（菊花进度条）
    private var spinner: UIActivityIndicatorView!
     
    //插件初始化的时候传入当前的视图控制器
    init() {
         
        //初始化活动状态指示器
//        if #available(iOS 13.0, *) {
//            self.spinner = UIActivityIndicatorView(style: .large)
//            self.spinner.backgroundColor = RGB(232, 232, 232)
//            self.spinner.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
//            print(self.spinner.frame)
//        } else {
//            // Fallback on earlier versions
//            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
//            self.spinner.backgroundColor = RGB(232, 232, 232)
//        }
//        self.spinner.center = self.viewController.view.center
    }
     
    //开始发起请求
    func willSend(_ request: RequestType, target: TargetType) {
        //请求时在界面中央显示一个活动状态指示器
        DispatchQueue.main.async {
//            self.viewController.view.addSubview(self.spinner)
//            self.spinner.startAnimating()
            ZKHudLoadingFrame.show()
        }
        
    }
     
    //收到请求
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
        //移除界面中央的活动状态指示器
        
         
        DispatchQueue.main.async {
//            self.spinner.removeFromSuperview()
//            self.spinner.stopAnimating()
            ZKHudLoadingFrame.hide()
        }
       
        //只有请求错误时会继续往下执行
//            guard case let Result.failure(error) = result else { return }
//
//            //弹出并显示错误信息
//            let message = error.errorDescription ?? "未知错误"
//            let alertViewController = UIAlertController(title: "请求失败",
//                                                        message: "\(message)",
//                                                        preferredStyle: .alert)
//            alertViewController.addAction(UIAlertAction(title: "确定", style: .default,
//                                                        handler: nil))
//            viewController.present(alertViewController, animated: true)
    }
    
    
}
