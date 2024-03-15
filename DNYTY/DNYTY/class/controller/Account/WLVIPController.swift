//
//  WLVIPController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit
import MJRefresh

class WLVIPController: ZKViewController {

    private var userLevelInfo: UserLevelInfo?
    private var curLevelInfo: LevelModel?
    private var nextLevelInfo: LevelModel?
    private var mj_header: MJRefreshNormalHeader?
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        return scrollView
    }()
    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = "VIP"
        aView.rightBtn.setTitle("vip0".wlLocalized, for: .normal)
        return aView
    }()
    private lazy var topView: WLLevelView = {
        let aView = WLLevelView()
        return aView
    }()
    private lazy var middleView: WLConditionView = {
        let aView = WLConditionView()
        aView.backgroundColor = .white
        aView.progressView.progress = 0.1
        return aView
    }()
    private lazy var bottomView: WLAwardKindView = {
        let aView = WLAwardKindView()
        return aView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        getUserLevelInfo()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(navView)
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        scrollView.addSubview(middleView)
        scrollView.addSubview(bottomView)
        setMj_header()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.width.equalTo(kScreenWidth)
        }
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(220)
        }
        middleView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(topView.snp.bottom).offset(5)
            make.height.equalTo(125)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(middleView.snp.bottom)
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        navView.rightBtn.rx.tap.bind { [unowned self] _ in
            let vc = WLVIPRecordController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }.disposed(by: rx.disposeBag)
        //权益说明
        topView.btn.rx.tap.bind { [unowned self] _ in
            self.navigator.show(segue: .vipEquity, sender: self)
        }.disposed(by: rx.disposeBag)
    }
    func setMj_header() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.scrollView.mj_header = self.mj_header
    }
    @objc func refreshData() {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "refresh_queue1")
        
        group.enter()
        queue1.async {
            self.getUserLevelInfo()
            group.leave()
        }
        
        group.wait()
        self.mj_header?.endRefreshing()
    }
}

extension WLVIPController {
    func getLevelExplain() {
        WLProvider.request(.levelExplain) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel: [LevelModel] = Array(JSONString: json["data"].rawString() ?? "") {
                            if dataModel.count > 0 {
                                let nextLevelModel = self.getNextLevel(list: dataModel)
                                if let deposit = nextLevelModel?.depositMoney {
                                    self.middleView.need.text = "/ " + "\(deposit/100)"
                                    if let cur = self.userLevelInfo?.depositAmount {
                                        self.middleView.differ.text = "vip6".wlLocalized + "\((deposit-cur)/100)"
                                        self.middleView.progressView.progress = Float(cur / deposit)
                                    }
                                    
                                }
                                self.setSomeValues()
                            }
                            
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func getNextLevel(list: [LevelModel]) -> LevelModel? {
        let cur = userLevelInfo?.levelCurrent ?? 0
        let curLevel = "LV" + "\(cur)"
        var curLevelModel: LevelModel?
        for level in list {
            if level.name == curLevel {
                curLevelModel = level
                break
            }
        }
        self.curLevelInfo = curLevelModel
        topView.moneyLab.text =  "vip26".wlLocalized + " >= " + ((curLevelModel?.depositMoney ?? 0) / 100).stringValue
        //根据curLevelModel.icon设置等级图片
        if let icon = curLevelModel?.icon {
            self.topView.levelImg.sd_setImage(with: URL(string: icon), completed: nil)
        }
        
        let nextLevel = "LV" + "\(cur + 1)"
        //根据nextLevel查找nextLevelModel
        var nextLevelModel: LevelModel?
        for level in list {
            if level.name == nextLevel {
                nextLevelModel = level
                break
            }
        }
        self.nextLevelInfo = nextLevelModel
        return nextLevelModel
    }
    //设置赠送彩金，转卡彩金，月礼金的值
    func setSomeValues() {
        if let levelModel = curLevelInfo {
            bottomView.improveView.lab.text = "\(levelModel.promoteHandsel / 100)"
            let transferDoule = Double(levelModel.transferHandsel) ?? 0
            bottomView.weekView.lab.text = "\(transferDoule / 100)" + "%"
            bottomView.monthView.lab.text = "\(levelModel.monthlyMoney / 100)"
        }
    }
    func getUserLevelInfo() {
        WLProvider.request(.userLevelInfo) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = UserLevelInfo.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.userLevelInfo = dataModel
                            
                            self.middleView.titleLab.text = "vip3".wlLocalized + "\"VIP\(dataModel.levelCurrent+1)\"" + "vip4".wlLocalized
                            self.middleView.current.text = "\(dataModel.depositAmount/100)"
                            self.getLevelExplain()
                            
                        }
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
}
