//
//  WLAccountController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/16.
//

import UIKit
import MJRefresh

class WLAccountController: ZKViewController {

    private var mj_header: MJRefreshNormalHeader?
    private let dataList = [WLAccountDataStruct(imgName: "person_profit", title: "account7".wlLocalized), WLAccountDataStruct(imgName: "vip_icon", title: "VIP"), WLAccountDataStruct(imgName: "wallet_icon", title: "account9".wlLocalized), WLAccountDataStruct(imgName: "bankCard_icon", title: "account9Txt".wlLocalized),WLAccountDataStruct(imgName: "spread_icon", title: "account10".wlLocalized), WLAccountDataStruct(imgName: "discount_info1", title: "account11".wlLocalized), WLAccountDataStruct(imgName: "finance_record", title: "account13".wlLocalized), WLAccountDataStruct(imgName: "game_record", title: "account14".wlLocalized), WLAccountDataStruct(imgName: "help_center", title: "account15".wlLocalized)]
    //, WLAccountDataStruct(imgName: "phone_download", title: "手机下载")
    private lazy var topView: WLAccountTopView = {
        let aView = WLAccountTopView()
        aView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 260)
        return aView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLAccountCell.self, forCellReuseIdentifier: "account")
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.backgroundColor = RGB(22, 23, 44)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = topView
        return tableView
    }()
    
    let vipBtn: ZKVipButton = {
        let btn = ZKVipButton()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfile()
        getWallet()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ZKLoginUser.shared.isLogin {
            self.navigator.show(segue: .login, sender: self)
            return
        }
        navigationController?.isNavigationBarHidden = true
        getWallet2()
    }

    override func initSubView() {
//        view.addSubview(topView)
        view.addSubview(tableView)
        view.addSubview(vipBtn)
        setMj_header()
    }
    
    override func layoutSubView() {
//        topView.snp.makeConstraints { make in
//            make.left.right.top.equalToSuperview()
//            make.height.equalTo(260)
//        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(-NAV_STATUS_HEIGHT)
        }
        
        vipBtn.snp.makeConstraints { make in
            make.left.equalTo(-70)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
        

    }
    override func bindViewModel() {
        
        vipBtn.rx.beginShow.bind { [weak self] isShow in
            
            guard let self = self else {
                return
            }
            
            if isShow {
                self.vipBtn.snp.remakeConstraints { make in
                    make.left.equalTo(0)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-100)
                }
            } else {
                self.vipBtn.snp.remakeConstraints { make in
                    make.left.equalTo(-70)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-100)
                }
            }
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }.disposed(by: rx.disposeBag)
        
        tableView.reloadData()
        //刷新
        topView.refreshBtn.rx.tap
            .bind { [unowned self] _ in
                getWallet()
            }.disposed(by: rx.disposeBag)
        //退出
        topView.exitBtn.rx.tap
            .bind { [unowned self] _ in
                logout()
            }.disposed(by: rx.disposeBag)
        //充值
        topView.funcView.rechangeView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                self.tabBarController?.selectedIndex = 2
            }.disposed(by: rx.disposeBag)
        //提现
        topView.funcView.withdrawView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                let vc = WLWithdrawController()
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: rx.disposeBag)
        //公告
        topView.funcView.noticeView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                let vc = WLNoticesController()
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: rx.disposeBag)
        //vip图标点击
        vipBtn.rx.open.bind { [unowned self] _ in
                let vc = WLVIPController()
                navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: rx.disposeBag)
        
    }
    func setMj_header() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.tableView.mj_header = self.mj_header
    }
    @objc func refreshData() {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "refresh_queue1")
        let queue2 = DispatchQueue(label: "refresh_queue2")
        
        group.enter()
        queue1.async {
            self.getUserProfile()
            group.leave()
        }
        group.enter()
        queue2.async {
            self.getWallet()
            group.leave()
        }
        group.wait()
        self.mj_header?.endRefreshing()
    }
//    func showExitAlert() {
//        let alertController = UIAlertController.init(title: "提示", message: "确认退出吗？", preferredStyle: .alert)
//        let cancel = UIAlertAction.init(title: "取消", style: .cancel) { _ in
//
//        }
//        let exit = UIAlertAction.init(title: "确认", style: .default) { [unowned self] _ in
//            logout()
//        }
//        alertController.addAction(cancel)
//        alertController.addAction(exit)
//        self.navigationController?.pushViewController(alertController, animated: true)
//    }

}

extension WLAccountController {
    func getUserProfile() {
        WLProvider.request(.wlUserProfile) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserProfileDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            if let username = dataModel.user_name {
                                self.topView.nameLab.text = "account0".wlLocalized + "," + username
                            }
                            
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func getWallet() {
        WLProvider.request(.thirdList(refresh: 0)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLWallet.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.topView.amountLab.text = dataModel.sumBalance.divide100().stringValue
                        }
                    }
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    //请求时不显示加载动画的
    func getWallet2() {
        WLProvider2.request(.thirdList(refresh: 0)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLWallet.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.topView.amountLab.text = dataModel.sumBalance.divide100().stringValue
                        }
                    }
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    //退出登录
    func logout() {
        WLProvider.request(.logout) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state != 2 {
                        DefaultWireFrame.showPrompt(text: baseModel.message)
                    }
                    ZKLoginUser.shared.clean()
                    UIApplication.appDeltegate.presentInitialScreen()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension WLAccountController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "account") as! WLAccountCell
        cell.data = dataList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = WLProfileController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = WLVIPController()
            self.navigationController?.pushViewController(vc, animated: true)
        
        case 2:
            let vc = WLAllWalletController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            self.navigator.show(segue: .bankCard, sender: self)
        case 4:
            //self.navigator.show(segue: .h5(page: .agency), sender: self)
            let vc = WLSpreadController()
            vc.isTab = false
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = WLBenefitInfoController()
            self.navigationController?.pushViewController(vc, animated: true)

        case 7:
            let vc = WLGameRecordController()
            self.navigationController?.pushViewController(vc, animated: true)

        case 6:
            self.navigator.show(segue: .financial, sender: self)

        case 8:
            self.navigator.show(segue: .helpCenter, sender: self)

        default:
            break
        }
        
    }
    
}
