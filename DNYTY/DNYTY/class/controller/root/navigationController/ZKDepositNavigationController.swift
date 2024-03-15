//
//  ZKRechargeNavigationController.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit

class ZKDepositNavigationController: ZKNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .white
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white

            appearance.titleTextAttributes = [
                .font: kMediumFont(16),
                .foregroundColor: UIColor(hexString: "#30333A") ?? UIColor.black
            ]

            appearance.shadowImage = UIImage(color: UIColor.clear)
            appearance.setBackIndicatorImage(RImage.navi_back(), transitionMaskImage: RImage.navi_back())


            
            navigationBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                navigationBar.scrollEdgeAppearance = appearance
            }
        }
        navigationBar.tintColor = RGB(102, 109, 124)
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
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
