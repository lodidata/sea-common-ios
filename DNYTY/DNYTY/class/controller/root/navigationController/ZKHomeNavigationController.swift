//
//  ZKHomeNavigationController.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit

class ZKHomeNavigationController: ZKNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.tintColor = .white
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(hexString: "#0E0D20")

            appearance.titleTextAttributes = [
                .font: kMediumFont(16),
                .foregroundColor: UIColor.white
            ]

            appearance.shadowImage = UIImage(color: UIColor.clear)
            appearance.setBackIndicatorImage(RImage.navi_back(), transitionMaskImage: RImage.navi_back())


            
            navigationBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                navigationBar.scrollEdgeAppearance = appearance
            }
        }
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
