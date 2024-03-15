//
//  ZKTabBarController.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit

class ZKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func sj_topViewController() -> UIViewController? {
        if selectedIndex == NSNotFound {
            return nil
        }
        return selectedViewController
    }
    
    override var shouldAutorotate: Bool {
        sj_topViewController()?.shouldAutorotate ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        sj_topViewController()?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        sj_topViewController()?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        sj_topViewController()?.prefersStatusBarHidden ?? false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        sj_topViewController()?.preferredStatusBarStyle  ?? .default
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
