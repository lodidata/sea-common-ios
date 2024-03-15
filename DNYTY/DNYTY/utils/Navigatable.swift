//
//  Navigatable.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import Foundation
import LiveChat
import MessageUI
protocol Navigatable {
    var navigator: Navigator { get }
}

class Navigator {
    typealias NavigationController = UINavigationController
    
    static var `default` = Navigator()

    // MARK: - segues list, all app scenes
    // 页面场景
    enum Scene {
        case tabs
        case login
        case hotGame(viewModel: ZKHotGameViewModel)
        case register
        case forgetAccount
        case forgetPwd1
        case forgetPwd2(phone: String)
        case gcashDeposit
        case cardDeposit
        case payHelp
        case localBankDeposit
        case autoTopup
        case depositRecord
        case webView(url: URL)
        case notifiList(list: [WLNoticeAppDataModel])
        case bankCard
        case addBankCard
        case financial
        case accountDetail
        case depositRecord2
        case applys
        case h5(page: ZKH5Page)
        case zhuanpan
        case vipEquity
        case player(url: URL?)
        case discountDetail(model: WLUserActiveListDataModel)
        case helpCenter
     
//        case search(viewModel: SearchViewModel)
//        case languages(viewModel: LanguagesViewModel)
//        case users(viewModel: UsersViewModel)
//        case userDetails(viewModel: UserViewModel)
//        case repositories(viewModel: RepositoriesViewModel)
//        case repositoryDetails(viewModel: RepositoryViewModel)
//        case contents(viewModel: ContentsViewModel)
//        case source(viewModel: SourceViewModel)
//        case commits(viewModel: CommitsViewModel)
//        case branches(viewModel: BranchesViewModel)
//        case releases(viewModel: ReleasesViewModel)
//        case pullRequests(viewModel: PullRequestsViewModel)
//        case pullRequestDetails(viewModel: PullRequestViewModel)
//        case events(viewModel: EventsViewModel)
//        case notifications(viewModel: NotificationsViewModel)
//        case issues(viewModel: IssuesViewModel)
//        case issueDetails(viewModel: IssueViewModel)
//        case linesCount(viewModel: LinesCountViewModel)
//        case theme(viewModel: ThemeViewModel)
//        case language(viewModel: LanguageViewModel)
//        case acknowledgements
//        case contacts(viewModel: ContactsViewModel)
//        case whatsNew(block: WhatsNewBlock)
        case safari(URL)
//        case safariController(URL)
//        case webController(URL)
    }

    // 跳转方式
    enum Transition {
        case root(in: UIWindow) //rootviewcontroller
        case navigation(type: HeroDefaultAnimationType)
        case customModal(type: HeroDefaultAnimationType)
        case modal
        case detail
        case alert
        case custom
    }

    // MARK: - 根据页面场景得到 viewController
    func get(segue: Scene) -> UIViewController? {
        switch segue {
        case .tabs:
            let tabBarVC = ZKHomeTabBarController()
            return tabBarVC
        case .login:
            let viewModel = ZKLoginViewModel()
            let loginVC = WLLoginViewController(viewModel: viewModel)
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.hidesBottomBarWhenPushed = true
            return loginVC
        case .register:
            let viewModel = WLRegisterViewModel()
            let registerVC = WLRegisterController(viewModel: viewModel)
            registerVC.hidesBottomBarWhenPushed = true
            return registerVC
        case .forgetAccount:
            let forgetAccountVC = WLForgetAccountController()
            return forgetAccountVC
        case .forgetPwd1:
            let viewModel = ZKForgetPsw1ViewModel()
            let forgetPwd1VC = WLForgetPwd1Controller(viewModel: viewModel)
            return forgetPwd1VC
        case .forgetPwd2(let phone):
            let viewModel = ZKForgetPsw2ViewModel(phone: phone)
            let forgetPwd2VC = WLForgetPwd2Controller(viewModel: viewModel)
            return forgetPwd2VC
        case .hotGame(let viewModel):
            let vc = ZKHomeHotGameViewController(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .gcashDeposit:
            let viewModel = ZKGcashDepositViewModel()
            let vc = ZKGcashDepositViewController(viewModel: viewModel)
            //vc.hidesBottomBarWhenPushed = true
            return vc

        case .payHelp:
            let vc = ZKPayHelpViewController()
            vc.modalPresentationStyle = .overFullScreen
            return vc
        case .cardDeposit:
            let viewModel = ZKCardDepositViewModel()
            let vc = ZKCardDepositViewController(viewModel: viewModel)
            //vc.hidesBottomBarWhenPushed = true
            return vc

        case .localBankDeposit:
            let viewModel = ZKLocalBankDepostViewModel()
            let vc = ZKLocalBankDepostViewController(viewModel: viewModel)
            //vc.hidesBottomBarWhenPushed = true
            return vc
        case .depositRecord:
            let viewModel = ZKDepositRecordViewModel()
            let vc = ZKDepositRecordViewController(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .discountDetail(let model):
            let vc = WLDiscountDetailController()
            vc.dataModel = model
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .webView(let url):
            let vc = ZKHomeNavigationController(rootViewController: ZKGameWebViewController(gameURL: url))
            vc.modalPresentationStyle = .fullScreen
            vc.hidesBottomBarWhenPushed = true
            //vc.modalPresentationStyle = .fullScreen
            return vc
        case .notifiList(let list):
            let viewModel = WLAfterLoginAlertViewModel(items: list)
            let vc = WLAfterLoginAlertViewController(viewModel: viewModel)
            vc.modalPresentationStyle = .overFullScreen
            return vc
        case .bankCard:
            let viewModel = ZKBankCardViewModel()
            let vc = ZKBankCardViewController(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .addBankCard:
            let viewModel = ZKAddBankCardViewModel()
            let vc = ZKAddBankCardViewController(viewModel: viewModel)
            return vc
        case .financial:
            let viewModel = ZKFinancialViewModel()
            let vc = ZKFinancialViewController(viewModel: viewModel)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .accountDetail:
            let vm = ZKAccountDetailViewModel()
            let vc = ZKAccountDetailViewController(viewModel: vm)
            return vc
        case .depositRecord2:
            let vm = ZKDepositRecord2ViewModel()
            let vc = ZKDepositRecord2ViewController(viewModel: vm)
            return vc
        case .applys:
            let vm = ZKApplysViewModel()
            let vc = ZKApplysViewController(viewModel: vm)
            return vc
        case .h5(let page):
            let vc = ZKH5ViewController(page: page)
            vc.hidesBottomBarWhenPushed = true
            return vc
        case .zhuanpan:
            let vc = WLTurntableController()
            return vc
        case .vipEquity:
            let vm = ZKVipEquityViewModel()
            let vc = ZKVipEquityViewController(viewModel: vm)
            return vc
        case .player(let url):
            let vc = ZKPlayerViewController(url: url)
            return vc
        case .autoTopup:
            let vm = ZKAutoTopupViewModel()
            let vc = ZKAutoTopupViewController(viewModel: vm)
            return vc
        case .helpCenter:
            let vc = ZKHelpCenterViewController()
            return vc
       
//        case .search(let viewModel): return SearchViewController(viewModel: viewModel, navigator: self)
//        case .languages(let viewModel): return LanguagesViewController(viewModel: viewModel, navigator: self)
//        case .users(let viewModel): return UsersViewController(viewModel: viewModel, navigator: self)
//        case .userDetails(let viewModel): return UserViewController(viewModel: viewModel, navigator: self)
//        case .repositories(let viewModel): return RepositoriesViewController(viewModel: viewModel, navigator: self)
//        case .repositoryDetails(let viewModel): return RepositoryViewController(viewModel: viewModel, navigator: self)
//        case .contents(let viewModel): return ContentsViewController(viewModel: viewModel, navigator: self)
//        case .source(let viewModel): return SourceViewController(viewModel: viewModel, navigator: self)
//        case .commits(let viewModel): return CommitsViewController(viewModel: viewModel, navigator: self)
//        case .branches(let viewModel): return BranchesViewController(viewModel: viewModel, navigator: self)
//        case .releases(let viewModel): return ReleasesViewController(viewModel: viewModel, navigator: self)
//        case .pullRequests(let viewModel): return PullRequestsViewController(viewModel: viewModel, navigator: self)
//        case .pullRequestDetails(let viewModel): return PullRequestViewController(viewModel: viewModel, navigator: self)
//        case .events(let viewModel): return EventsViewController(viewModel: viewModel, navigator: self)
//        case .notifications(let viewModel): return NotificationsViewController(viewModel: viewModel, navigator: self)
//        case .issues(let viewModel): return IssuesViewController(viewModel: viewModel, navigator: self)
//        case .issueDetails(let viewModel): return IssueViewController(viewModel: viewModel, navigator: self)
//        case .linesCount(let viewModel): return LinesCountViewController(viewModel: viewModel, navigator: self)
//        case .theme(let viewModel): return ThemeViewController(viewModel: viewModel, navigator: self)
//        case .language(let viewModel): return LanguageViewController(viewModel: viewModel, navigator: self)
//        case .acknowledgements: return AcknowListViewController()
//        case .contacts(let viewModel): return ContactsViewController(viewModel: viewModel, navigator: self)
//
//        case .whatsNew(let block):
//            if let versionStore = block.2 {
//                return WhatsNewViewController(whatsNew: block.0, configuration: block.1, versionStore: versionStore)
//            } else {
//                return WhatsNewViewController(whatsNew: block.0, configuration: block.1)
//            }

        case .safari(let url):
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return nil

//        case .safariController(let url):
//            let vc = SFSafariViewController(url: url)
//            return vc
//
//        case .webController(let url):
//            let vc = WebViewController(viewModel: nil, navigator: self)
//            vc.load(url: url)
//            return vc
        }
    }

    
    /// 返回视图
    /// - Parameters:
    ///   - sender: 当前视图
    ///   - toRoot: 是否回根视图
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }

    
    func dismiss(sender: UIViewController?) {
        sender?.dismiss(animated: true, completion: nil)
    }
    /// 显示场景界面
    /// - Parameters:
    ///   - segue: 场景页面
    ///   - sender: 父控制器
    ///   - transition: 跳转方式
    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation(type: .cover(direction: .left))) {
        if let target = get(segue: segue) {
            show(target: target, sender: sender, transition: transition)
        }
    }


    /// 显示场景界面
    /// - Parameters:
    ///   - target: 目标页面
    ///   - sender: 当前页面，或 navigation
    ///   - transition: 跳转方式
    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {
        switch transition {
        case .root(in: let window):
            window.rootViewController = target
            window.makeKeyAndVisible()
            return
        case .custom: return
        default: break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        if let nav = sender as? UINavigationController {
            // push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }

        switch transition {
        case .navigation(let type):
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.hero.navigationAnimationType = .autoReverse(presenting: type)
                nav.pushViewController(target, animated: true)
            }
        case .customModal(let type):
            // present modally with custom animation
            DispatchQueue.main.async {
                //let nav = NavigationController(rootViewController: target)
                target.hero.modalAnimationType = .autoReverse(presenting: type)
                sender.present(target, animated: true, completion: nil)
            }
        case .modal:
            // present modally
            DispatchQueue.main.async {
                //let nav = NavigationController(rootViewController: target)
                sender.present(target, animated: true, completion: nil)
            }
        case .detail:
            DispatchQueue.main.async {
                //let nav = NavigationController(rootViewController: target)
                target.showDetailViewController(target, sender: nil)
            }
        case .alert:
            DispatchQueue.main.async {
                sender.present(target, animated: true, completion: nil)
            }
        default: break
        }
    }

    //发送信息
    func toInviteContact(withPhone phone: String) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        vc.body = ""
        vc.recipients = [phone]
        return vc
    }
    
    func openUrl(url: URL?) {
        guard let url = url else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension UINavigationController {
    func popViewController() {
        self.popViewController(animated: true)
    }
}

