//
//  ZKConst.swift
//  ZKBaseSwiftProject
//
//  Created by guina on 2021/6/18.
//  Copyright © 2021 zk. All rights reserved.
//

import Foundation
import UIKit

let kLicenseId = "14146056"

//MARK: - size
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenBounds = UIScreen.main.bounds
let is_iPhoneX_All = (UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896 || UIScreen.main.bounds.size.height == 780 || UIScreen.main.bounds.size.height == 844 || UIScreen.main.bounds.size.height == 926) ? true : false
let TABBAR_BOTTOM : CGFloat = is_iPhoneX_All ? 34 : 0//距离底部
let NAV_HEIGHT :CGFloat = is_iPhoneX_All ? 88 : 64//导航栏高度
let NAV_STATUS_HEIGHT :CGFloat = is_iPhoneX_All ? 44 : 20//状态栏高度

//MARK: - path
let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
let kCachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!
let kTemporaryPath = NSTemporaryDirectory()

//MARK: -
let kAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""

let RImage = R.image.self
let kGamePlaceholderImage = RImage.game_placeholder()

//let RString = R.string.localizable.self
//let RFont = R.font.self
//
//let kPlaceholderGameMiddle = RImage.game_placeholder_middle()
//let kPlaceholderGameLarge = RImage.game_placeholder_large()
//
//
let kRememberPsdKey = "kRememberPsdKey"
let kUserPasswordKey = "kUserPasswordKey"
let kUserNameKey = "kUserNameKey"
//let kProfileUserNameKey = "kProfileUserNameKey"
