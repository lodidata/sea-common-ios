//
//  ZKHomeTabBarViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit

enum ZKHomeTabItemType {
    case home
    case discount
    case deposit
    case withdraw
    case account
    
    var image: UIImage? {
        switch self {
        case .home:
            return RImage.tab_home()
        case .discount:
            return RImage.tab_discount()
        case .deposit:
            return RImage.tab_recharge()
        case .withdraw:
            return RImage.tab_gudong()
        case .account:
            return RImage.tab_account()
        }
    }
    
    var selectImage: UIImage? {
        switch self {
        case .home:
            return RImage.tab_home_select()
        case .discount:
            return RImage.tab_discount_sel()
        case .deposit:
            return RImage.tab_recharge_sel()
        case .withdraw:
            return RImage.tab_gudong_sel()
        case .account:
            return RImage.tab_account_sel()
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "footer0".wlLocalized
        case .discount:
            return "footer1".wlLocalized
        case .deposit:
            return "footer2".wlLocalized
        case .withdraw:
            return "footer3".wlLocalized
        case .account:
            return "footer4".wlLocalized
        }
    }
    
    var viewController: UIViewController {
        var vc: UINavigationController? = nil
        switch self {
        case .home:
            //ZKHomeViewController
            let vm = ZKHomeViewModel()
            vc = ZKHomeNavigationController.init(rootViewController: ZKHomeViewController(viewModel: vm))
            vc?.isNavigationBarHidden = true
        case .discount:

            vc = ZKNavigationController.init(rootViewController: WLDiscountController())
            vc?.isNavigationBarHidden = true
        case .deposit:
            
            let viewModel = ZKDepositViewModel()
            let vc1 = ZKDepositViewController(viewModel: viewModel)
            
            vc = ZKDepositNavigationController.init(rootViewController: ZKDepositViewController(viewModel: viewModel))
            
            
        case .withdraw:
//            vc = ZKNavigationController.init(rootViewController: WLWithdrawController())
//            vc?.isNavigationBarHidden = true
//            vc?.navigationBar.tintColor = RGB(102, 109, 124)
            vc = ZKNavigationController.init(rootViewController: WLSpreadController())
            vc?.isNavigationBarHidden = true
        case .account:
            vc = ZKDepositNavigationController(rootViewController: WLAccountController())
            vc?.isNavigationBarHidden = true
        }
        
        guard let vc = vc else { return UIViewController() }
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
        return vc
    }
    
}

class ZKHomeTabBarViewModel: ZKViewModel {

    let items: [ZKHomeTabItemType] = [.home, .discount, .deposit, .withdraw, .account ]
}
