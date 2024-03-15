//
//  AppDelegate.swift
//  DNYTY
//
//  Created by WL on 2022/6/2
//  
//
    

import UIKit
import IQKeyboardManager

import LiveChat

@main
class AppDelegate: UIResponder, UIApplicationDelegate, Navigatable {
    
    var navigator: Navigator {
        Navigator.default
    }
    
    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LiveChat.licenseId = kLicenseId
        
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        self.presentInitialScreen()
        return true
    }

 

    //初始化窗口
    func presentInitialScreen() {
       
        guard let window = window else { return }
        window.backgroundColor = .white
        //window.rootViewController = ViewController()
        self.navigator.show(segue: .tabs, sender: nil, transition: .root(in: window))

        
    }
    
    
    func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        .all
    }


}

