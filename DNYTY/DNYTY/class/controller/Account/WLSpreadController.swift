//
//  WLSpreadController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit
import MJRefresh

class WLSpreadController: ZKViewController {

    var isTab = true
    private var configDataModel: WLStartConfigDataModel?
    private var videoDataModel: WLUserVideoDataModel?
    private var monthDataModel: [WLSpreadMonthQueryDataModel]? = []
    private var mj_header: MJRefreshNormalHeader?
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var topView: WLSpreadTopView = {
        let aView = WLSpreadTopView()
        aView.closeBtn.isHidden = isTab
        return aView
    }()
    private lazy var agencyView: WLSpeadAgencyView = {
        let aView = WLSpeadAgencyView()
        return aView
    }()
    private lazy var realView: WLRealDataView = {
        let aView = WLRealDataView()
        return aView
    }()
    private lazy var yesterdayView: WLYesterdayDataView = {
        let aView = WLYesterdayDataView()
        return aView
    }()
    private lazy var gameInfoView: WLSpreadGameInfoView = {
        let aView = WLSpreadGameInfoView()
        return aView
    }()
    private lazy var otherCostView: WLOtherCostView = {
        let aView = WLOtherCostView()
        return aView
    }()
    private lazy var chartsView: WLChartView = {
        let aView = WLChartView()
        return aView
    }()
    private lazy var monthQueryView: WLMonthQueryView = {
        let aView = WLMonthQueryView()
        return aView
    }()
    private lazy var bottomView: WLBottomBtnView = {
        let aView = WLBottomBtnView()
        return aView
    }()
    private lazy var shareAlertView: WLShareAlertAlphaView = {
        let aView = WLShareAlertAlphaView()
        return aView
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ZKLoginUser.shared.isLogin {
            self.navigator.show(segue: .login, sender: self)
            return
        }
        //不显示加载动画的
        getWallet2()
        userAgentRptWebRequest2()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        profileRequest()
        getWallet()
        getAgentMarket()
        userVideoRequest(showBlock: nil)
        userAgentRptWebRequest()
    }
    

    override func initSubView() {
        super.initSubView()
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        scrollView.addSubview(agencyView)
        scrollView.addSubview(realView)
        scrollView.addSubview(yesterdayView)
        scrollView.addSubview(gameInfoView)
        scrollView.addSubview(otherCostView)
        scrollView.addSubview(chartsView)
        scrollView.addSubview(monthQueryView)
        scrollView.addSubview(bottomView)
        setMj_header()
    }
    func setMj_header() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.scrollView.mj_header = self.mj_header
    }
    @objc func refreshData() {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "refresh_queue1")
        let queue2 = DispatchQueue(label: "refresh_queue2")
        let queue3 = DispatchQueue(label: "refresh_queue3")
        let queue4 = DispatchQueue(label: "refresh_queue4")
        let queue5 = DispatchQueue(label: "refresh_queue5")
        group.enter()
        queue1.async {
            self.profileRequest()
            group.leave()
        }
        group.enter()
        queue2.async {
            self.getWallet()
            group.leave()
        }
        group.enter()
        queue3.async {
            self.getAgentMarket()
            group.leave()
        }
        group.enter()
        queue4.async {
            self.userVideoRequest(showBlock: nil)
            group.leave()
        }
        group.enter()
        queue5.async {
            self.userAgentRptWebRequest()
            group.leave()
        }
        group.wait()
        self.mj_header?.endRefreshing()
    }
    override func layoutSubView() {
        super.layoutSubView()
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(-NAV_STATUS_HEIGHT)
            make.width.equalTo(kScreenWidth)
        }
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(370)
        }
        agencyView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(86)
        }
        realView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(agencyView.snp.bottom).offset(30)
            make.height.equalTo(370)
        }
        yesterdayView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(realView.snp.bottom).offset(20)
            make.height.equalTo(130)
        }
        gameInfoView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(yesterdayView.snp.bottom).offset(10)
            make.height.equalTo(0)
        }
        otherCostView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(gameInfoView.snp.bottom)
            make.height.equalTo(60)
        }
        chartsView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(otherCostView.snp.bottom).offset(20)
            //make.height.equalTo(60)
            let height = (kScreenWidth-30)*(256.0/343) + 60 + 13
            make.height.equalTo(height)
        }
        monthQueryView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(chartsView.snp.bottom).offset(10)
            make.height.equalTo(0)
        }
        bottomView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(monthQueryView.snp.bottom)
            make.height.equalTo(60)
            make.bottom.equalToSuperview()
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        //关闭按钮
        topView.closeBtn.rx.tap.bind { [unowned self] _ in
            navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        //钱包按钮
        topView.walletBtn.rx.tap.bind { [unowned self] _ in
            let vc = WLWithdrawController()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: rx.disposeBag)
        //复制推荐码
        topView.recommendView.copyIcon.rx.tap.bind { [unowned self] _ in
            UIPasteboard.general.string = topView.recommendView.recommendLab.text
            self.showHUDMessage("new8".wlLocalized)
        }.disposed(by: rx.disposeBag)
        //复制链接
        topView.recommendView.copyLinkView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            if let data = configDataModel { //请求到了链接
                UIPasteboard.general.string = data.h5_url + "?code=" + (topView.recommendView.recommendLab.text ?? "")
                self.showHUDMessage("new8".wlLocalized)
            } else {
                configRequestAgain(tag: nil)
            }
            
        }.disposed(by: rx.disposeBag)
        //一键分享
        topView.recommendView.shareView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            UIApplication.appDeltegate.window?.addSubview(shareAlertView)
            shareAlertView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }.disposed(by: rx.disposeBag)
        //规则说明
        topView.recommendView.ruleIntroView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            let vc = WLSpreadRuleController()
            navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: rx.disposeBag)
        //观看视频
        topView.recommendView.lookVideoView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            if let data = videoDataModel { //请求到了视频链接
                navigator.show(segue: .player(url: URL(string: data.link)), sender: self, transition: .modal)
            } else {
                userVideoRequest(true) {
                    navigator.show(segue: .player(url: URL(string: videoDataModel?.link ?? "")), sender: self, transition: .modal)
                }
            }
        }.disposed(by: rx.disposeBag)
        //分享弹窗事件
        shareAlertView.alertView.whatsappView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 0)
        }.disposed(by: rx.disposeBag)
        shareAlertView.alertView.telegramView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 1)
        }.disposed(by: rx.disposeBag)
        shareAlertView.alertView.lineView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 2)
        }.disposed(by: rx.disposeBag)
        shareAlertView.alertView.viberView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 3)
        }.disposed(by: rx.disposeBag)
        shareAlertView.alertView.messergerView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 4)
        }.disposed(by: rx.disposeBag)
        shareAlertView.alertView.instagramView.rx.tapGesture().skip(1).bind { [unowned self] _ in
            openSocialApp(tag: 5)
        }.disposed(by: rx.disposeBag)
        bottomView.btn.rx.tap.bind { [unowned self] _ in
            bottomView.btn.isSelected = !bottomView.btn.isSelected
            if bottomView.btn.isSelected {
                monthQueryView.snp.updateConstraints { make in
                    if let data = monthDataModel {
                        make.height.equalTo(47 + data.count * 60)
                    }
                }
            } else {
                monthQueryView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
        }.disposed(by: rx.disposeBag)
        
    }
    func openSocialApp(tag: Int) {
        if configDataModel == nil { //没值，说明请求没成功，重新去请求
            configRequestAgain(tag: tag)
            return
        }
        var text = (configDataModel?.h5_url ?? "") + "?code=" + (topView.recommendView.recommendLab.text ?? "")
        let charactersToEscape = "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "
        let allowedCharacters = NSCharacterSet.init(charactersIn: charactersToEscape).inverted
        text = text.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
        
        switch tag {
        case 0:
            let urlStr = "whatsapp://send?text=" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new13".wlLocalized)
            }
        case 1:
            let urlStr = "tg://msg?text=" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new14".wlLocalized)
            }
        case 2:
            let urlStr = "line://msg/text/" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new15".wlLocalized)
            }
        case 3:
            let urlStr = "viber://forward?text=" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new16".wlLocalized)
            }
        case 4:
            let urlStr = "fb-messenger://share=" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new17".wlLocalized)
            }
        case 5:
            let urlStr = "Instagram://library?AssetPath=" + text
            if UIApplication.shared.canOpenURL(URL.init(string: urlStr)!) {
                UIApplication.shared.open(URL.init(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                self.showHUDMessage("new18".wlLocalized)
            }
        default:
            break
        }
    }
}

extension WLSpreadController {
    
    func profileRequest() {
        WLProvider.request(.wlUserProfile) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserProfileDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            if let username = dataModel.user_name {
                                self.topView.nameLab.text = username
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
    //获取复制链接的前部分h5_url
    func configRequest() {
        WLProvider.request(.startConfig) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLStartConfigDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.configDataModel = dataModel
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    //获取复制链接的前部分h5_url
    func configRequestAgain(tag: Int?) {
        WLProvider.request(.startConfig) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLStartConfigDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.configDataModel = dataModel
                            //点击复制链接时如果没请求到链接，就再请求，此时isAgain的值是true，请求成功后执行下面的block
                            if let tag = tag { //如果有值说明是分享时没取到值请求的
                                self.openSocialApp(tag: tag)
                            } else { //tag没值说明是请求复制链接时没取到值请求的
                                UIPasteboard.general.string = dataModel.h5_url + "?code=" + (self.topView.recommendView.recommendLab.text ?? "")
                                self.showHUDMessage("new8".wlLocalized)
                            }
                            
                        }
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    //可以获取推荐码
    func getAgentMarket() {
        WLProvider.request(.wlAgentMarket) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLAgentMarketDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            
                            self.topView.recommendView.recommendLab.text = dataModel.marker_link?.code
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    //视频播放地址,如果第一次请求失败，就再请求
    func userVideoRequest(_ isAgain: Bool = false, showBlock: (() -> Void)?) {
        WLProvider.request(.wlUserVideo) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserVideoDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            print(dataModel.link)
                            self.videoDataModel = dataModel
                            //点击观看视频时如果没请求到视频链接，就再请求，此时isAgain的值是true，请求成功后执行下面的block
                            if isAgain {
                                if let block = showBlock {
                                    block()
                                }
                            }
                        } else {
                            if isAgain {
                                self.showHUDMessage(baseModel.message)
                            }
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    //代理接口
    func userAgentRptWebRequest() {
        WLProvider.request(.wlRptWeb) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserAgentRptWebDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            
                            self.rptWebSet(dataModel: dataModel)
                        }
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func userAgentRptWebRequest2() {
        WLProvider2.request(.wlRptWeb) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserAgentRptWebDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            
                            self.rptWebSet(dataModel: dataModel)
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func rptWebSet(dataModel: WLUserAgentRptWebDataModel) {
        if let data = dataModel.agent_info {
            self.setAgentView(data: data)
        }
        if let data = dataModel.today_info {
            self.setRealDataView(data: data)
        }
        if let data = dataModel.yesterday_info {
            self.setYesterdayView(data: data)
        }
        if let data = dataModel.month_bet_list {
            self.setMonthQueryView(data: data)
        }
        if let data = dataModel.day_bet_list {
            self.setChartView(data: data)
        }
    }
    
    func setAgentView(data: WLRptWebAgentInfoDataModel) {
        agencyView.totalView.btn.setTitle(data.all_agent.stringValue, for: .normal)
        agencyView.directlyUnderView.btn.setTitle(data.direct_agent.stringValue, for: .normal)
        agencyView.underlineView.btn.setTitle(data.next_agent.stringValue, for: .normal)
    }
    func setRealDataView(data: WLRptWebTodayInfoDataModel) {
        for (index, item) in realView.dataList.enumerated() {
            //let model = realView.dataList[index]
            switch index {
            case 0:
                item.data = data.bet_amount
            case 1:
                item.data = data.next_bet_amount
            case 2:
                item.data = data.total_bet_amount
            case 3:
                item.data = data.new_register.stringValue
            case 4:
                item.data = data.next_agent.stringValue
            case 5:
                item.data = data.recharge_user.stringValue
            case 6:
                item.data = data.recharge_amount
            case 7:
                item.data = data.profits
            default:
                break
            }
        }
        realView.collectionView.reloadData()
    }
    func setYesterdayView(data: WLRptWebYesterdayInfoDataModel) {
        yesterdayView.totalWaterView.dataLab.text = data.bet_amount
        yesterdayView.totalProfileView.dataLab.text = data.profits
        yesterdayView.companyCostView.dataLab.text = data.fee_amount
        //其他成本
        otherCostView.otherLab.text = data.other_fee
        //游戏分类列表
        if data.game_list.count > 0 {
            self.gameInfoView.dataList = data.game_list
//            gameInfoView.isHidden = false
            gameInfoView.snp.updateConstraints { make in
                make.height.equalTo(40+data.game_list.count*40)
            }
            otherCostView.isHidden = false
            otherCostView.snp.updateConstraints { make in
                make.height.equalTo(60)
            }
        } else {
            gameInfoView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            otherCostView.isHidden = true
            otherCostView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        }
        
    }
    func setMonthQueryView(data: [WLSpreadMonthQueryDataModel]) {
        monthQueryView.dataList = data
        monthDataModel = data
//        monthQueryView.snp.updateConstraints { make in
//            make.height.equalTo(47 + 60 * data.count)
//        }
    }
    func setChartView(data: [WLRptWebDayBetListDataModel]) {
        var dateList = [String]()
        var betAmountList = [Double]()
        var bkgeList = [Double]()
        
        for i in 0..<data.count {
            let date = transferDate(date: data[i].time)
            dateList.append(date)
            let betNumber = NSNumber.init(string: data[i].bet_amount)
            let bkgeNumber = NSNumber.init(string: data[i].bkge)
            betAmountList.append(betNumber?.doubleValue ?? 0)
            bkgeList.append(bkgeNumber?.doubleValue ?? 0)
        }
        
        chartsView.setChartModel(dates: dateList, betAmounts: betAmountList, bkges: bkgeList)
    }
    func transferDate(date: String) -> String {
        if date.count >= 10 {
            let month = String(date.dropFirst(5).prefix(2))
            let day = String(date.dropFirst(8).prefix(2))
            return month + "/" + day
        } else {
            return ""
        }
        
    }
}
