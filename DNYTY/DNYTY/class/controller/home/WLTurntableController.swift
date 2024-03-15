//
//  WLTurntableController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/27.
//

import UIKit

class WLTurntableController: WLViewController {

    private var resultModel: WLActiveLuckyPostDataModel?
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        return scrollView
    }()
    private lazy var ruleBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("lotteryTxt1".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(15)
        btn.addTarget(self, action: #selector(ruleBtnClick), for: .touchUpInside)
        return btn
    }()
    private lazy var rewardView: RewardView = {
        let rewardView = RewardView()
        rewardView.delegate = self
        return rewardView
    }()
    private lazy var handleView: WLLotteryHandleView = {
        let aView = WLLotteryHandleView()
        aView.startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchUpInside)
        aView.refreshBtn.addTarget(self, action: #selector(refreshBtnClick), for: .touchUpInside)
        return aView
    }()
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = .black
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        aView.layer.borderColor = UIColor.init(hexString: "E9C163")?.cgColor
        aView.layer.borderWidth = 0.5
        aView.clipsToBounds = true
        return aView
    }()
    
    private lazy var listView: ScrollChatView = {
        let aView = ScrollChatView.init()
        aView.backgroundColor = UIColor.init(hexString: "1B1B1B")
        aView.speed = 1
        aView.font = kMediumFont(14)
        aView.color = UIColor.init(hexString: "E9C163")
        aView.padding = 5
        aView.yx_delegate = self
//        aView.dataList = ["444","222","333"]
        return aView
    }()
    private lazy var ruleView: WLLuckyRuleView = {
        let aView = WLLuckyRuleView.init()
        return aView
    }()
    private lazy var resultView: WLLuckyResultView = {
        let aView = WLLuckyResultView.init()
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navView.backBtn.setImage(UIImage.init(named: "fanhui"), for: .normal)
        navView.titleLab.text = "lotteryTit".wlLocalized
        navView.titleLab.textColor = .white
        navView.backgroundColor = .black
        luckyRequest()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize.init(width: kScreenWidth, height: 660)
    }
    override func initSubView() {
        super.initSubView()
        view.addSubview(scrollView)
        
        scrollView.addSubview(rewardView)
        scrollView.addSubview(ruleBtn)
        scrollView.addSubview(handleView)
        scrollView.addSubview(bgView)
        bgView.addSubview(listView)
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.width.equalTo(kScreenWidth)
        }
        
        rewardView.snp.makeConstraints { make in
            make.width.height.equalTo(kScreenWidth - 30)
//            make.height.equalTo(345)
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        ruleBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(rewardView)
            make.width.equalTo(36)
            make.height.equalTo(20)
        }
        handleView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(rewardView.snp.bottom)
            make.height.equalTo(70)
            make.width.equalTo(kScreenWidth)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(handleView.snp.bottom).offset(15)
            make.height.equalTo(170)
            make.width.equalTo(kScreenWidth - 30)
        }
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    @objc func startBtnClick() {
        let curCount = Int(self.handleView.countLab.text ?? "0") ?? 0
        if curCount >= 1 {
            rewardView.lottery()
        } else {
            self.showHUDMessage("new20".wlLocalized)
        }
        
    }
    @objc func refreshBtnClick() {
        luckyRequest()
        
    }
    @objc func ruleBtnClick() {
        UIApplication.shared.keyWindow?.addSubview(ruleView)
        ruleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    //幸运轮盘-点击抽奖-get-获取相关信息
    func luckyRequest() {
        WLProvider.request(.wlGetActiveLucky) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLActiveLuckyDataModel(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.handleView.countLab.text = dataModel.luckyCount?.stringValue
//                            self.ruleView.textView.text = dataModel.luckySetting?.description
                            let htmlString = String.init(format: "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><body style=\"color: rgb(0, 0, 0)\">%@</body></html>", (dataModel.luckySetting?.description ?? ""))
                            self.ruleView.webView.loadHTMLString(htmlString, baseURL: nil)
                            self.setupLottery(dataModel: dataModel)
                            self.listView.dataList = dataModel.winHistory?.map({ history in
                                return (history.user ?? "") + "lotteryTxt4".wlLocalized + (history.money?.divide100().stringValue ?? "")
                            })
                        }
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    

    func setupLottery(dataModel: WLActiveLuckyDataModel) {
        
        if dataModel.rule?.count ?? 0 > 0 {
            var lotteries = [Reward.Lottery]()
            for (index, item) in dataModel.rule!.enumerated() {
                let lottery = Reward.Lottery(id: item.award_id?.intValue ?? 0, begin: (Float(index) * 45), end: (Float(index + 1) * 45), title: item.award_id?.stringValue ?? "", image: item.img ?? "")
                lotteries.append(lottery)
            }
            rewardView.set(lotteries: lotteries)
        }
        
        
    }
}
extension WLTurntableController: RewardViewDelegate {
    func lottery(_ completion: @escaping ((Bool, Reward.Award) -> Void)) {
        // 模拟网路请求，服务端返回 Reward.Award
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let award = Reward.Award(id: self.id, rotationNum: 5)
//            completion(true, award)
//            self.id -= 1
//            self.id = self.id <= 0 ? 8 : self.id
//        }
        WLProvider.request(.wlPostActiveLucky) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLActiveLuckyPostDataModel(JSON: json["data"].dictionaryObject ?? [:]) {
                            print(dataModel.award_name ?? "")
                            //把抽奖次数减一
                            let curCount = Int(self.handleView.countLab.text ?? "0")
                            self.handleView.countLab.text = String((curCount ?? 0) - 1)
                            
                            self.resultModel = dataModel
                            if let awardId = dataModel.award_id?.intValue {
                                let award = Reward.Award(id: awardId, rotationNum: 5)
                                completion(true, award)
                            }
                            
//                            self.id = dataModel.award_id?.intValue ?? 0
                        }
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func animationDidStart(_ anim: CAAnimation) {}
    
    func animationDidStop(_ anim: CAAnimation) {
        if resultModel?.award_id == 9 { //award_id等于9表示未中奖
            resultView.titleLab.text = "new21".wlLocalized
            resultView.resultLab.text = "lotteryTxt7".wlLocalized
        } else {
            resultView.titleLab.text = "new21".wlLocalized
            resultView.resultLab.text = "lotteryTxt5".wlLocalized + (resultModel?.award_money?.divide100().stringValue ?? "") + "new22".wlLocalized
        }
        
        UIApplication.shared.keyWindow?.addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
extension WLTurntableController: ScrollChatViewDelegate {
    func scrollChatTextView(_ view: ScrollChatView!, with index: Int, withText text: String!) {
        
    }
    
    
}
