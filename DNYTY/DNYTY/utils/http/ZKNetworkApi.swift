//
//  ZKNetworkApi.swift
//  ZKBaseSwiftProject
//
//  Created by guina on 2021/8/24.
//  Copyright © 2021 zk. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import RxSwift
import SwiftUI
import ObjectMapper
import SwiftyJSON

enum ZKH5Page {
    case about
    case help
    case rlues
    case gameRlues
    case agency
    //case agencyTab
    case helpCenter
    case vipRights
    case spreadRule
    case helpDeposits
    case helpWithdrawals
    case helpFAQs
    case helpUserPolicy
    case helpPrivacyPolicy
    case helpOther
    
    
    var url: URL? {
        var urlString = ""
        switch self {
        case .about:
            urlString = "/pages/home/about/aboutUs"
        case .help:
            urlString = "/pages/home/about/help"
        case .rlues:
            urlString = "/pages/home/about/rlues"
        case .gameRlues:
            urlString = "/pages/home/about/gameRlues"
        case .agency:
            urlString = "/pages/agency/index"
//        case .agencyTab:
//            urlString = "/pages/agency/manage?isapp=1&isTab=1"
        case .helpCenter:
            urlString = "/pages/help/index"
        case .vipRights:
            urlString = "/pages/vip/introduce"
        case .spreadRule:
            urlString = "/pages/agency/rule_text"
        case .helpDeposits:
            urlString = "/pages/help/about/deposits"
        case .helpWithdrawals:
            urlString = "/pages/help/about/withdrawals"
        case .helpFAQs:
            urlString = "/pages/help/about/FAQs"
        case .helpUserPolicy:
            urlString = "/pages/help/about/userPolicy"
        case .helpPrivacyPolicy:
            urlString = "/pages/help/about/privacyPolicy"
        case .helpOther:
            urlString = "/pages/help/about/others"
        
        }
        
        
        return URL(string: baseH5URLString + urlString + String(format: "?isapp=1&lang=%@", serverHeaders["lang"] ?? ""))
    }

}

let baseH5URLString = "https://sea.caacaya.com"
let baseURLString = "https://sea-api-www.caacaya.com";
//let baseURLString = "http://192.168.5.170:8081";

var serverHeaders: [String : String] {

    
    let token = ZKLoginUser.shared.model?.token ?? ""
   //print([ "lang": "zh-cn", "pl": "ios", "Authorization": token ])
    var lang = WLLanguageManager.shared.currentLanguage
    if lang == "zh-Hans" {
        lang = "zh-cn"
    }

    
    return [ "lang": lang, "pl": "ios", "Authorization": token ]

    
    //return [ "lang": "zh-cn", "pl": "ios", "Authorization": "" ]
    
}

let ZKProvider = MoyaProvider<ZKNetWorkApi>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose)), RequestTokenAlertPlugin()])
let WLProvider = MoyaProvider<ZKNetWorkApi>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose)),  WLIndicatorPlugin(), RequestTokenAlertPlugin()])
let WLProvider2 = MoyaProvider<ZKNetWorkApi>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))])



enum ZKNetWorkApi {
    case login(username: String, password: String, code: String = "", token: String = "") //登录
    case logout //退出登录
    case registerMoblieCode(telphone: String) //注册发送验证码
//    case rechargeBank //银行列表
    case register(user_name: String, mobile: String, password: String, re_password: String, verify_code: String, invit_code: String? = nil)
    case forgetMoblieCode(telphone: String) //忘记密码发送验证码
    case forgetSettingPsd(name: String, password: String, code: String)
    case profile //个人详细资料
    case captchaImage //获取图形验证码
    case deletCard(id: Int) //删除银行卡
    case bankList //银行列表
    case addBankCard(bankId: Int, depositBank: String, name: String, account: String)
    case capitalTypeList(type: Int = 1)
    case capitalList(type: Int, gameType: Int, start: String, end: String, page: Int, pageSize: Int)
//    case jackpot //头奖
    case homeMenu(id: Int? = nil) //主页菜单 二级游戏id 不传获取一二级分类 传ID获取第三级游戏列表
    case communityList //社区论坛列表
    case startConfig //启动后配置参数
//    case notice //通知公告
    case noticeList(page: Int, page_size: Int) //公告列表
//    case activeList(deposit: Int) //活动列表 1：只获取充值优惠  0：全部
    case thirdList(refresh: Int) //获取第三方钱包金额列表
    case bankAccount //获取充值银行卡账户
//    case reportRebet(start: String, end: String) //返水记录
//    case activeApplys(id: Int? = nil, page: Int? = 1, pageSize: Int? = 10)
    case homeBanner(type: Int = 2) //轮播
    case gameApp(id: Int)
//    case todayTop //今日热门
//    case favoriteList //收藏游戏列表
//    case favoriteGame(id: Int, status: Bool) //收藏游戏和删除收藏
//    case gameHotList //热门游戏
    case searchGame(id: Int? = nil, name: String? = nil) //搜索游戏 二级分类下的游戏或者模糊搜索游戏名 menu表进同步ID菜单列表(传game_id才有)，hot热门游戏 list 游戏列表
//    case thirdBalance(game_type: String) //获取第三方金额
    case thirdRefresh //回收第三方所有钱包金额（一键回收）
    case userActiveList(active_type_id: Int? = nil) //获取活动列表
    case userActiveTypes //优惠类型
//    case wlAgent(page: Int, page_size: Int) //个人中心-我的团队列表
//    case wlbetting(type_name: String, start_time: String, end_time: String, page: Int, page_size: Int) //团队投注记录
    case wlbettingFiter //团队投注记录筛选
//    case wlactiveBkge //返佣活动 推广->代理说明
//    case wlBkgeRatio //获取代理返佣比例
//    case wlStartConfig //启动后配置参数
    case wlUserBankBind //会员中心-获取会员绑定的银行卡列表
//
    case wlSafetyLoginpwd(password_old: String, password_new: String, repassword_new: String) //安全中心-修改登录密码
    case wlActiveApplys(page: Int, page_size: Int) //获得优惠的资金明细表
//    case wlReportRebet(start_time: String, end_time: String, page: Int, page_size: Int) //个人报表-返水记录
    case wlGetWalletWithdraw //会员提现-获取线上提款信息
    case wlPutWalletWithdraw(withdraw_money: Int64, withdraw_card: String) //竖版会员提现-会员线上提款申请
    case wlWithdrawHistory(start_time: String, end_time: String, page: Int, page_size: Int) //查询用户提款记录
    case wlGetActiveLucky //幸运轮盘-信息
    case wlPostActiveLucky //幸运轮盘-点击抽奖
//    case wlSafetyWithdrawpwd(password: String, new_password: String) //安全中心-修改取款密码
    case pageHot
    case allGame
    case wlUserProfile //个人详细资料
//    case wlUserAgentBkge(page: Int, page_size: Int) //查询我的佣金
//
    case depositList(start: String = "", end: String = "", page: Int = 1, pageSize: Int = 10) //存款记录
//    case depositCoupon //查询是否接受优惠
//    case onDepositCoupon(status: Bool) //打开接受优惠
//    //线上充值
    case rechargeOnlines(receiptId: Int, //支付通道ID
                         bankData: String = "",
                         money: String, //充值金额
                         discountActive: String = "0", //优惠活动id
                         payType: String = "",
                         payCode: String = "") //非必传参数， 某些第三方银行必须要银行则必传参数 ，取bank_data中的pay_code值
    //线下充值
    case rechargeOfflines(bankId: Int,
                          depositName: String,
                          receiptId: Int,
                          money: String,
                          depositTime: String
                         )
    case payTypeList //支付渠道
    case wlbaseInfo(name: String)
//    case walletWithdraw //获取提款信息
    case withdrawList(start: String = "", end: String = "", page: Int = 1, pageSize: Int = 10) //取款记录
//    case withdraw(money: String, pin: String) //取款
    case messageList(type: Int? = nil, page: Int = 1, pageSize: Int = 10) //消息列表
    case readMessage(ids: String) //标记消息已读
    case deleteMessage(ids: String) //删除消息
    case userLevelInfo //用户等级信息
//    case baseInfo(name: String = "",
//                  avatar: String = "",
//                  gender: Int? = nil,
//                  city: String = "",
//                  address: String = "",
//                  nationality: String = "",
//                  birthPlace: String = "",
//                  birth: String = "",
//                  qq: String = "",
//                  wechat: String = "",
//                  nickname: String = "",
//                  skype: String = "",
//                  mobile: String = "",
//                  email: String = "") //完善个人资料
    case levelExplain //等级特权展示
//    case avatarList //获取头像
//    case setAvatar(id: Int) //设置头像
//
//    case wllotteryMessage(lottery_id: Int, lottery_number: String) //中奖信息展示
//    case wlGetlotteryInsertNumber(lottery_id: Int, lottery_number: String, page: Int, page_size: Int) //获取指定彩票猜奖号列表
//    case wlPostlotteryInsertNumber(lottery_id: Int, lottery_number: String, number: String) //输入彩票猜奖号
//    case wllotterHistory(id: Int, page: Int, page_size: Int)
//    case wlGetlotteryOrder(lottery_id: Int, start_time: String, end_time: String, page: Int, page_size: Int)//注单查询--彩票标准/快速
//
//    case lotteryList //彩票列表
//    case lotteryInfo(id: Int) //彩票轮次
//    case lotteryStruct(id: Int) //彩票玩法
    case getAutotopup //获取充值autotopup银行和卡号
//    case lotteryOrder(id: Int, pid: Int, lotteryNumber: String, play: [[String: Any]])
//    case wllotteryList //彩票列表
//    case wlTeamInfo(start_time: String, end_time: String) //团队概况
//    case wlNextquery(start_time: String, end_time: String, page: Int, page_size: Int) //下级查询
//    case wlNextlink //推广链接
//    case wlNewBkge(date: String) //推广-返佣历史

    case wlNoticeApp //首页公告消息
    case wlGameRecord(start_time: String, end_time: String, page: Int, page_size: Int, type_name: String, category: String, key: String)
    case wlActiveSlot
    case wlUserVideo
    case wlAgentMarket
    case wlRptWeb

}

extension ZKNetWorkApi: TargetType {
    var baseURL: URL {
        URL(string: baseURLString)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/auth/login"
        case .registerMoblieCode:
            return "/user/auth/register/mobliecode"
        case .profile:
            return "/user/profile"
        case .captchaImage:
            return "/block/condition/captcha/image"
//        case .jackpot:
//            return "/game/third/jackpot"
        case .homeMenu:
            return "/home/menu/vertical"
        case .communityList:
            return "community/list"
        case .startConfig:
            return "/start/config"
        case .bankList:
            return "/user/bank"
        case .addBankCard:
            return "/user/bank"
        case .pageHot:
            return "/home/game/pageHot"
        case .gameApp:
            return "/game/third/app"
//        case .notice:
//            return "/user/notice/app"
        case .noticeList:
            return "/user/notice"
//        case .activeList:
//            return "/user/active/list"
//        case .rechargeBank:
//            return "/user/wallet/recharge/bank"
        case .register:
            return "/user/auth/okeRegister"
        case .forgetMoblieCode:
            return "/user/auth/forget"
        case .forgetSettingPsd:
            return "/user/auth/forget"
        case .thirdList:
            return "/game/third/list"
        case .bankAccount:
            return "/user/wallet/bankAccount"

        case .homeBanner:
            return "/block/home/app/banner"
        case .capitalTypeList:
            return "/block/condition/capital"
        case .capitalList:
            return "/user/capital"
        case .allGame:
            return "/home/game/all"
//        case .todayTop:
//            return "/home/game/todayTop"
//        case .favoriteList:
//            return "/user/favorite"
//        case .favoriteGame:
//            return "/user/favorite"
//        case .gameHotList:
//            return "/home/game/hot"
//
//        case .thirdBalance:
//            return "/game/third/balance"
        case .thirdRefresh:
            return "/game/third/refresh"
        case .userActiveList:
            return "/user/active/list"
        case .userActiveTypes:
            return "/user/active/types"
        case .deletCard:
            return "/user/bank"
//        case .wlAgent:
//            return "/user/agent"
//        case .wlbetting:
//            return "/user/agent/betting"
        case .wlbettingFiter:
            return "/user/agent/betting/filter"
//        case .wlactiveBkge:
//            return "/user/active/bkge"
//        case .wlBkgeRatio:
//            return "/user/agent/bkgeRatio"
//        case .wlStartConfig:
//            return "/start/config"
        case .wlUserBankBind:
            return "/user/bank/bind"
//
        case .wlSafetyLoginpwd:
            return "/user/safety/loginpwd"
        case .wlActiveApplys:
            return "/user/active/applys"
//        case .wlReportRebet:
//            return "/user/report/rebet"
        case .wlGetWalletWithdraw:
            return "/user/wallet/verticalWithdraw"
        case .wlPutWalletWithdraw:
            return "/user/wallet/withdraw/oke"
        case .wlWithdrawHistory:
            return "/user/capital/withdraw"
        case .wlGetActiveLucky:
            return "/user/active/lucky"
        case .wlPostActiveLucky:
            return "/user/active/lucky"
//        case .wlSafetyWithdrawpwd:
//            return "/user/safety/withdrawpwd"
        case .wlUserProfile:
            return "/user/profile"
//        case .wlUserAgentBkge:
//            return "/user/agent/bkge"
//
        case .searchGame:
            return "/home/list"
//        case .reportRebet:
//            return "/user/report/rebet"
//        case .activeApplys:
//            return "/user/active/applys"
        case .depositList:
            return "/user/capital/deposit"
//        case .depositCoupon:
//            return "/user/depositCoupon"
//        case .onDepositCoupon:
//            return "/user/depositCoupon"
        case .rechargeOnlines:
            return "/user/wallet/recharge/onlines"
//        case .walletWithdraw:
//            return "/user/wallet/verticalWithdraw"
        case .withdrawList:
            return "/user/capital/withdraw"
//        case .withdraw:
//            return "/user/wallet/verticalWithdraw"
        case .logout:
            return "/user/auth/logout"
        case .messageList:
            return "/user/message"
        case .readMessage:
            return "/user/message"
        case .deleteMessage:
            return "/user/message"
        case .userLevelInfo:
            return "/user/level/info"
//        case .baseInfo:
//            return "/user/baseinfo"
        case .levelExplain:
            return "/user/level/explain"
//        case .avatarList:
//            return "/user/avatar"
//        case .setAvatar:
//            return "/user/avatar"
        case .rechargeOfflines:
            return "/user/wallet/recharge/offlines"
        case .payTypeList:
            return "/user/wallet/paytype/onlines"
        case .wlbaseInfo:
            return "/user/baseinfo"
        case .wlGameRecord:
            return "game/common/order"
//        case .wllotteryMessage:
//            return "/game/lottery/message"
//        case .wlGetlotteryInsertNumber:
//            return "/game/lottery/InsertNumber"
//        case .wlPostlotteryInsertNumber:
//            return "/game/lottery/InsertNumber"
//        case .wllotterHistory:
//            return "/game/lottery/history"
//        case .wlGetlotteryOrder:
//            return "/game/lottery/order"
//
//        case .lotteryList:
//            return "/game/lottery/simple"
//        case .lotteryInfo:
//            return "/game/lottery/info"
//        case .lotteryStruct:
//            return "/game/lottery/struct"
        case .getAutotopup:
            return "/user/wallet/recharge/autotopup"
//        case .lotteryOrder:
//            return "/game/lottery/order"
//        case .wllotteryList:
//            return "/game/lottery/list"
//        case .wlTeamInfo:
//            return "/user/agent/newBkge/team"
//        case .wlNextquery:
//            return "/user/agent/newBkge/sub"
//        case .wlNextlink:
//            return "/user/agent/link"
//        case .wlNewBkge:
//            return "/user/agent/newBkge/list"
        case .wlNoticeApp:
            return "/user/notice/app"
        case .wlActiveSlot:
            return "/user/active/slot"
        case .wlUserVideo:
            return "/user/video"
        case .wlAgentMarket:
            return "/user/agent/market"
        case .wlRptWeb:
            return "/user/agent/rpt/web"
//        default:
//            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .registerMoblieCode:
            return .post
  
        case .profile:
            return .get
        case .deletCard:
            return .delete
        case .addBankCard:
            return .put
//        case .captchaImage:
//            return .get
//        case .jackpot:
//            return .get
//        case .homeMenu:
//            return .get
        case .startConfig:
            return .get
//        case .notice:
//            return .get
//        case .activeList:
//            return .get
        case .register:
            return .post
        case .forgetMoblieCode:
            return .put
        case .forgetSettingPsd:
            return .post
        case .thirdList:
            return .get

//        case .gameBanner:
//            return .get
//        case .favoriteGame:
//            return .post
//
        case .wlSafetyLoginpwd:
            return .put
        case .wlPutWalletWithdraw:
            return .put
        case .wlPostActiveLucky:
            return .post
//        case .wlSafetyWithdrawpwd:
//            return .post
//
//        case .onDepositCoupon:
//            return .post
        case .rechargeOnlines:
            return .put
//        case .withdraw:
//            return .put
        case .readMessage:
            return .put
        case .deleteMessage:
            return .delete
//        case .baseInfo:
//            return .post
//        case .setAvatar:
//            return .post
        case .rechargeOfflines:
            return .put
//        case .wlPostlotteryInsertNumber:
//            return .post
//        case .lotteryOrder:
//            return .post
        case .wlbaseInfo:
            return .post
        default:
            return .get
        }
    }

    //单元测试
    var sampleData: Data {
        Data()
    }

    var task: Task {
        switch self {
        case .login(let username, let password, let code, let token):
            return .requestParameters(parameters: ["name": username, "password": password, "code": code, "token": token], encoding: URLEncoding.default)
        case .registerMoblieCode(let telphone):
            return .requestParameters(parameters: ["telphone": telphone], encoding: URLEncoding.default)
        
//        case .activeList(let deposit):
//            return .requestParameters(parameters: ["deposit": deposit], encoding: URLEncoding.default)
        case .register(let user_name,  let mobile, let password, let re_password, let verify_code, let invit_code):
            var para: [String: Any] = ["mobile": mobile, "verify_code": verify_code, "password": password, "re_password": re_password, "user_name": user_name]

            if let invitCode = invit_code {
                para["invit_code"] = invitCode
            }

            return .requestParameters(parameters: para, encoding: URLEncoding.default)
        case .forgetMoblieCode(let telphone):
            return .requestParameters(parameters: ["name": telphone, "type": "mobile", "code": "", "token": ""], encoding: URLEncoding.default)
        case .forgetSettingPsd(let name, let password, let code):
            return .requestParameters(parameters: ["name": name, "password": password, "code" : code], encoding: URLEncoding.default)
        case .thirdList(let refresh):
            return .requestParameters(parameters: ["refresh": refresh], encoding: URLEncoding.default)

        case .homeBanner(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
//        case .favoriteGame(let id, let status):
//            return .requestParameters(parameters: ["game_id": id, "status": status], encoding: URLEncoding.default)
        case .homeMenu(let id):
            return .requestParameters(parameters: ["id": id ?? ""], encoding: URLEncoding.default)
//
//        case .thirdBalance(let game_type):
//            return .requestParameters(parameters: ["game_type": game_type], encoding: URLEncoding.default)
        case .userActiveList(let active_type_id):
            return .requestParameters(parameters: ["active_type_id": active_type_id ?? ""], encoding: URLEncoding.default)
        case .deletCard(let id):
            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
        case .addBankCard(let bankId, let depositBank, let name, let account):
            return .requestParameters(parameters: ["bank": bankId, "deposit_bank": depositBank, "name": name, "account": account], encoding: URLEncoding.default)
//        case .wlAgent(let page, let page_size):
//            return .requestParameters(parameters: ["page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlbetting(let type_name, let start_time, let end_time, let page, let page_size):
//            return .requestParameters(parameters: ["type_name": type_name, "start_time": start_time, "end_time": end_time, "page": page, "page_size": page_size], encoding: URLEncoding.default)
//
        case .wlSafetyLoginpwd(let password_old, let password_new, let repassword_new):
            return .requestParameters(parameters: ["password_old": password_old, "password_new": password_new, "repassword_new": repassword_new], encoding: URLEncoding.default)
        case .gameApp(let id):
            return .requestParameters(parameters: ["play_id": id], encoding: URLEncoding.default)
        case .wlActiveApplys(let page, let page_size):
            return .requestParameters(parameters: ["page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlReportRebet(let startTime, let endTime, let page, let page_size):
//            return .requestParameters(parameters: ["start_time": startTime, "end_time": endTime, "page": page, "page_size": page_size], encoding: URLEncoding.default)
        case .wlPutWalletWithdraw(let withdraw_money, let withdraw_card):
            return .requestParameters(parameters: ["withdraw_money": withdraw_money, "withdraw_card": withdraw_card], encoding: URLEncoding.default)
        case .wlWithdrawHistory(let start_time, let end_time, let page, let page_size):
            return .requestParameters(parameters: ["start_time": start_time, "end_time": end_time, "page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlSafetyWithdrawpwd(let password, let new_password):
//            return .requestParameters(parameters: ["password": password, "new_password": new_password], encoding: URLEncoding.default)
//        case .wlUserAgentBkge(let page, let page_size):
//            return .requestParameters(parameters: ["page": page, "page_size": page_size], encoding: URLEncoding.default)
//
        case .searchGame(let id, let name):
            return .requestParameters(parameters: ["game_id": id ?? "", "game_name": name ?? ""], encoding: URLEncoding.default)
//        case .reportRebet(let start, let end):
//            return .requestParameters(parameters: ["start_time": start, "end_time": end], encoding: URLEncoding.default)
//        case .activeApplys(let id, let page, let pageSize):
//            return .requestParameters(parameters: ["type_id": id ?? "", "page": page ?? "", "page_size": pageSize ?? ""], encoding: URLEncoding.default)
        case .depositList(let start,let end,let page,let pageSize):
            return .requestParameters(parameters: ["start_time": start, "end_time": end, "page": page, "page_size": pageSize], encoding: URLEncoding.default)
//        case .onDepositCoupon(let status):
//            return .requestParameters(parameters: ["status": status ? 1 : 0], encoding: URLEncoding.default)
        case .rechargeOnlines(let receiptId, let bankData, let money, let discountActive, let payType, let payCode):
            return .requestParameters(parameters: ["receipt_id": receiptId, "bank_data": bankData, "money": money, "discount_active": discountActive, "payCode": payCode, "pay_type": payType], encoding: URLEncoding.default)
        case .rechargeOfflines(let bankId, let depositName, let receiptId, let money, let depositTime):
            return .requestParameters(parameters: ["bank": bankId, "deposit_name": depositName, "receipt_id": receiptId, "money": money, "deposit_time": depositTime], encoding: URLEncoding.default)
        case .capitalTypeList(let type):
            return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
        case .capitalList(let type, let gameType, let start, let end, let page, let pageSize):
            return .requestParameters(parameters: ["type": type, "game_type": gameType, "start_time": start, "end_time": end, "page": page, "page_size": pageSize, "pc_or_h5": 1], encoding: URLEncoding.default)
        case .withdrawList(let start,let end,let page,let pageSize):
            return .requestParameters(parameters: ["start_time": start, "end_time": end, "display": "vertical", "page": page, "page_size": pageSize], encoding: URLEncoding.default)
//        case .withdraw(let money, let pin):
//            return .requestParameters(parameters: ["withdraw_money": money, "withdraw_pwd": pin], encoding: URLEncoding.default)
        case .messageList(let type, let page, let pageSize):
            return .requestParameters(parameters: ["type": type ?? "", "page": page, "page_size": pageSize], encoding: URLEncoding.default)
        case .readMessage(let ids):
            return .requestParameters(parameters: ["id": ids], encoding: URLEncoding.default)
        case .deleteMessage(let ids):
            return .requestParameters(parameters: ["id": ids], encoding: URLEncoding.default)
//        case .baseInfo(let name, let avatar, let gender, let city, let address, let nationality, let birthPlace, let birth, let qq, let wechat, let nickname, let skype, let mobile, let email):
//            return .requestParameters(parameters: ["name": name, "avatar": avatar, "gender": gender ?? "", "city": city, "address": address, "nationality": nationality, "birth_place": birthPlace, "birth": birth, "qq": qq, "wechat": wechat, "nickname": nickname, "skype": skype, "mobile": mobile, "email": email], encoding: URLEncoding.default)
//        case .setAvatar(let id):
//            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
//
//        case .wllotteryMessage(let lottery_id, let lottery_number):
//            return .requestParameters(parameters: ["lottery_id": lottery_id, "lottery_number": lottery_number], encoding: URLEncoding.default)
//        case .wlGetlotteryInsertNumber(let lottery_id, let lottery_number, let page, let page_size):
//            return .requestParameters(parameters: ["lottery_id": lottery_id, "lottery_number": lottery_number, "page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlPostlotteryInsertNumber(let lottery_id, let lottery_number, let number):
//            return .requestParameters(parameters: ["lottery_id": lottery_id, "lottery_number": lottery_number, "number": number], encoding: URLEncoding.default)
//        case .wllotterHistory(let id, let page, let page_size):
//            return .requestParameters(parameters: ["id": id, "page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlGetlotteryOrder(let lottery_id, let start_time, let end_time, let page, let page_size):
//            return .requestParameters(parameters: ["lottery_id": lottery_id, "start_time": start_time, "end_time": end_time,"page": page, "page_size": page_size], encoding: URLEncoding.default)
//
//        case .lotteryInfo(let id):
//            return .requestParameters(parameters: ["id": id], encoding: URLEncoding.default)
//        case .lotteryStruct(let id):
//            return .requestParameters(parameters: ["lottery_id": id], encoding: URLEncoding.default)
//        case .lotteryOrder(let id, let pid, let lotteryNumber, let play):
//            return .requestParameters(parameters: ["data": ["lottery_id": id, "pid": pid, "lottery_number": lotteryNumber, "play": play]], encoding: JSONEncoding.default)
//        case .wlTeamInfo(let start_time, let end_time):
//            return .requestParameters(parameters: ["start_time": start_time, "end_time": end_time], encoding: URLEncoding.default)
//        case .wlNextquery(let start_time, let end_time, let page, let page_size):
//            return .requestParameters(parameters: ["start_time": start_time, "end_time": end_time, "page": page, "page_size": page_size], encoding: URLEncoding.default)
//        case .wlNewBkge(let date):
//            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.default)
        case .wlbaseInfo(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.default)
        case .noticeList(let page, let page_size):
            return .requestParameters(parameters: ["page": page, "page_size": page_size], encoding: URLEncoding.default)
        case .wlGameRecord(let start_time, let end_time, let page, let page_size, let type_name, let category, let key):
            return .requestParameters(parameters: ["start_time": start_time, "end_time": end_time, "page": page, "page_size": page_size, "type_name": type_name, "category": category, "key": key], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: [:], encoding: Alamofire.URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        serverHeaders
    }
    
}

struct JSONObjectEncoding: ParameterEncoding {
    static let `default` = JSONObjectEncoding()

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()

        guard let json = parameters?["jsonArray"] else {
            return request
        }

        let data = try JSONSerialization.data(withJSONObject: json, options: [])

        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        request.httpBody = data

        return request
    }
}


extension Session {
    func serverRequest<Parameters: Encodable>(_ path: String,
                                              method: HTTPMethod = .get,
                                          parameters: Parameters? = nil,
                                             encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                             headers: HTTPHeaders? = nil,
                                         interceptor: RequestInterceptor? = nil,
                                     requestModifier: RequestModifier? = nil) -> DataRequest {
        request(baseURLString.appending(path), method: method, parameters: parameters, encoder: encoder, headers: headers, interceptor: interceptor, requestModifier: requestModifier)
        
    }
}


struct ServerResponse: Mappable {
    init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        state <- map["state"]
        data <- map["data"]
        message <- map["message"]
        attributes <- map["attributes"]
    }
    
    var state: Int = 0
    var data: Any?
    var message: String = ""
    var attributes: Any?
}

extension Moya.Response {
    func mapServerRespone(failsOnEmpty: Bool = true) throws -> ServerResponse {
        
        do {
            let json = try mapServerJSON()
            guard let result = ServerResponse(JSONString: json.rawString()!) else {
                return ServerResponse()
            }
            return result
        } catch {
            if failsOnEmpty {
                return ServerResponse()
            }
            throw MoyaError.jsonMapping(self)
        }
        
    }
    
    func mapMyJSON(failsOnEmpty: Bool = true) throws -> JSON {
        do {
            return try JSON(data: self.data)
        } catch {
            if failsOnEmpty {
                return JSON()
            }
            throw MoyaError.jsonMapping(self)
        }
        
    }
    
    func mapServerJSON(failsOnEmpty: Bool = true) throws -> JSON {
        do {
            return try JSON(data: self.data)
        } catch {
            if failsOnEmpty {
                return JSON(["state": self.statusCode, "message": self.description, "data": "" ])
            }
            throw MoyaError.jsonMapping(self)
        }
        
    }
    
}



extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func mapServerRespone(failsOnEmpty: Bool = true) -> Single<ServerResponse> {
        flatMap { .just( try $0.mapServerRespone(failsOnEmpty: failsOnEmpty)) }

    }
    
    func mapServerRespone<T>(_ transform: @escaping ((ServerResponse) -> T), failsOnEmpty: Bool = true) -> Single<T> {
        flatMap { _ in self.mapServerRespone(failsOnEmpty: failsOnEmpty).map(transform) }
    }
    
    func mapServerRespone<T>(_ transform: @escaping ((Int , Any?, String) -> T), failsOnEmpty: Bool = true) -> Single<T> {
        let json = self.mapMyJSON()
        return json.map { json in
            return transform(json["state"].intValue, json["data"].object, json["message"].stringValue)
        }
    }
    
    func mapServerRespone<T>(_ transform: @escaping ((Int , Any?, String, Any?) -> T), failsOnEmpty: Bool = true) -> Single<T> {
        let json = self.mapMyJSON()
        return json.map { json in
            return transform(json["state"].intValue, json["data"].object, json["message"].stringValue, json["attributes"].object)
        }
    }
    
    func mapServerJSON(failsOnEmpty: Bool = true) -> Single<(Int, JSON, String)> {
        self.mapMyJSON(failsOnEmpty: failsOnEmpty).map { json in
            return (json["state"].intValue, json["data"], json["message"].stringValue)
        }
    }
    
    func mapServerJSON<T>(_ transform: @escaping ((Int , JSON, String) -> T), failsOnEmpty: Bool = true) -> Single<T> {
        self.mapMyJSON(failsOnEmpty: failsOnEmpty).map { json in
            return transform(json["state"].intValue, json["data"], json["message"].stringValue)
        }
    }
    
    func mapServerJSON<T>(_ transform: @escaping ((Int , JSON, String, JSON) -> T), failsOnEmpty: Bool = true) -> Single<T> {
        self.mapMyJSON(failsOnEmpty: failsOnEmpty).map { json in
            return transform(json["state"].intValue, json["data"], json["message"].stringValue, json["attributes"])
        }
    }
    
    func mapServerObject<T: Mappable>(_ type: T.Type, failsOnEmpty: Bool = true) -> Single<T?> {
        self.mapMyJSON(failsOnEmpty: failsOnEmpty).map { json in
            guard let data = json["data"].dictionaryObject else {
                return nil
            }
            guard let object = T(JSON: data) else {
                return nil
            }
            return object
        }
    }
    
    func mapServerArray<T: BaseMappable>(_ type: T.Type, failsOnEmpty: Bool = true) -> Single<[T]> {
        self.mapMyJSON(failsOnEmpty: failsOnEmpty).map { json in
    
            if let jsonString = json["data"].rawString() {
                let model = Mapper<T>().mapArray(JSONString: jsonString) ?? []
                return model
            } else {
                return []
            }
            
            
            
        }
    }
    
    func mapMyJSON(failsOnEmpty: Bool = true) -> Single<JSON> {
        if failsOnEmpty {
            return flatMap {
                .just(try $0.mapMyJSON(failsOnEmpty: failsOnEmpty))
            }.catchAndReturn(JSON())
        }
        return flatMap {
            .just(try $0.mapMyJSON(failsOnEmpty: failsOnEmpty))
        }
    }
}

extension JSON {
    func mapObject<T: Mappable>(type: T.Type) -> T? {
        guard let jsonStr = self.rawString(), let object = T(JSONString: jsonStr) else {
            return nil
        }
        return object
    }
    
    func mapObjectArray<T: Mappable>(type: T.Type) -> [T] {
        guard let jsonStr = self.rawString(), let objectList: [T]
                = Array(JSONString: jsonStr) else {
            return []
        }
        return objectList
    }
}

//请求弹窗插件
final class RequestTokenAlertPlugin: PluginType {
    let disposeBag: DisposeBag = DisposeBag()
    //当前的视图控制器
    private var viewController: UIViewController {
        return UIApplication.appDeltegate.window!.rootViewController!.zk_top
    }
     
   
    //插件初始化的时候传入当前的视图控制器
    init() {
        
    }
     
    //开始发起请求
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
     
    //收到请求
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        
        switch result {
        case .success(let resp):
            guard let json = try? JSON(data: resp.data), let state = json["state"].int else {
                return
            }
            //11, 58, 59, 60, 125, 3001, 4002
            switch state {
            case 162, 59:
                ZKLoginUser.shared.clean()
                let msg = json["message"].stringValue
                UIApplication.appDeltegate.presentInitialScreen()
                self.viewController.promptFor(title: "card17".wlLocalized, message: msg, cancelAction: "card20".wlLocalized, animated: true, completion: nil).subscribe { _ in

                }.disposed(by: disposeBag)
            default:
                break
            }
        case .failure(let error):
            if error.response?.statusCode == 401 {
                ZKLoginUser.shared.clean()
                UIApplication.appDeltegate.presentInitialScreen()
                
            }
        }
        
        
        
        
        
          
        
       
    }
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        
        
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

enum ZKServerError {
    case serverError(state: Int, message: String)
}

enum ZKServerResult<T> {
    case respone(_ data: T)
    case failed(message: String)
    
    var data: T? {
        switch self {
        case .respone(let data):
            return data
        case .failed:
            return nil
        }
    }
    
    var message: String? {
        switch self {
        case .respone(let date):
            guard let msg = date as? String else { return nil }
            return msg
        case .failed(let message):
            return message
        }
    }
    
    var isOK: Bool {
        switch self {
        case .respone:
            return true
        case .failed:
            return false
        }
    }
}
// MARK: - new

//extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
//    func mapServer() -> Single<ZKServerResult> {
//
//        flatMap {
//            do {
//                return .just(ZKServerResult.respone(respone: try $0.mapMyJSON(failsOnEmpty: false)))
//            } catch(let error) {
//                return .just(.failed(error: error))
//            }
//        }
//
//    }
//
//}
//
//enum ZKServerError: Error {
//    case message(text: String)
//}
//
//enum ZKServerResult {
//    case respone(respone: JSON)
//    case failed(message: Error)
//
//    var data: JSON {
//        switch self {
//        case .respone(let respone):
//            return respone["data"]
//        default:
//            return JSON()
//        }
//    }
//
//    var state: Int {
//        switch self {
//        case .respone(let respone):
//            return respone["state"].intValue
//        default:
//            return -404
//        }
//    }
//
//    var message: String {
//        switch self {
//        case .respone(let respone):
//            return respone["message"].stringValue
//        default:
//            return ""
//        }
//    }
//
//    func mapObject<T: Mappable>(type: T.Type) -> T? {
//        guard case ZKServerResult.respone(let respone) = self else { return nil }
//        guard let jsonStr = respone["data"].rawString(), let object = T(JSONString: jsonStr) else {
//            return nil
//        }
//        return object
//    }
//
//    func mapObjectArray<T: Mappable>(type: T.Type) -> [T] {
//        guard case ZKServerResult.respone(let respone) = self else { return [] }
//        guard let jsonStr = respone["data"].rawString(), let objectList: [T]
//                = Array(JSONString: jsonStr) else {
//            return []
//        }
//        return objectList
//    }
//}
