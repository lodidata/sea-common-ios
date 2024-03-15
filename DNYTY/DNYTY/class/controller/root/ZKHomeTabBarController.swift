//
//  ZKHomeTabBarController.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit
import LiveChat

class ZKHomeTabBarController: ZKTabBarController, Navigatable {
    var navigator: Navigator {
        Navigator.default
    }
    let viewModel: ZKHomeTabBarViewModel
    
    init() {
        viewModel = ZKHomeTabBarViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    let kefuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.heroID = "chatView"
        btn.setBackgroundImage(RImage.kefu(), for: .normal)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        settingUI()
        bindViewModel()
        
    }
    
    
    func settingUI() {
        
        
        self.tabBar.isTranslucent = true;
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = UIColor.init(hexString: "111845")
        
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowColor = .clear
            appearance.backgroundColor = UIColor.init(hexString: "111845")
            appearance.backgroundEffect = nil
            
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        } else {

            UITabBar.appearance().backgroundColor = UIColor.init(hexString: "111845")
        }
        
        
        view.addSubview(kefuBtn)
        kefuBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-(49+40))
            make.right.equalTo(-25)
        }
        
//        let image = UIImage(named: "bg_tab")
//        if #available(iOS 13.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.shadowColor = .clear
//            appearance.backgroundColor = .clear;
//            appearance.backgroundEffect = nil
//            appearance.backgroundImage = image!.stretchableImage(withLeftCapWidth: Int(image!.size.width)/2, topCapHeight: Int(image!.size.height)/2)
//
//
//            tabBar.standardAppearance = appearance
//            if #available(iOS 15.0, *) {
//                tabBar.scrollEdgeAppearance = appearance
//            }
//        } else {
//
//            UITabBar.appearance().backgroundImage = image!.stretchableImage(withLeftCapWidth: Int(image!.size.width)/2, topCapHeight: Int(image!.size.height)/2)
//        }
    }

    
    func bindViewModel() {
        viewControllers = viewModel.items.map { $0.viewController }
        
        kefuBtn.rx.tap.bind { 
            LiveChat.presentChat()
        }.disposed(by: rx.disposeBag)
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



