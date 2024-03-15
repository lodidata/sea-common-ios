//
//  WLWithdraw2Controller.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit

class WLWithdraw2Controller: ZKViewController {

    private var dataModel: WLWalletWithdrawDataModel?
    private var bankDataModel: WLBankBindDataModel?
    //选中的银行卡
    private var showCard: WLBankBindListDataModel?
    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View()
        aView.rightBtn.setTitle("withdraw12".wlLocalized, for: .normal)
        aView.titleLab.text = "withdraw2".wlLocalized
        return aView
    }()
    private lazy var topView: WLWithdrawInfoView = {
        let aView = WLWithdrawInfoView()
        return aView
    }()
    private lazy var bottomView: WLWithdrawInfo2View = {
        let aView = WLWithdrawInfo2View()
        return aView
    }()
    private lazy var bankView: WLWithdrawBankInfoView = {
        let aView = WLWithdrawBankInfoView()
        aView.isHidden = true
        aView.selectBlock = { [weak self] data in
            self?.showCard = data
            self?.setCardInfo(card: data)
            self?.bankView.topView.icon.isSelected = false
            self?.recoveryBankView()
        }
        return aView
    }()
    private lazy var addBankView: WLAddBankView = {
        let aView = WLAddBankView()
        aView.isHidden = true
        return aView
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 30, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("withdraw2".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    private lazy var selectView: WLPickerView = {
        let aView = WLPickerView.init()
        aView.toolView.cancelBtn.addTarget(self, action: #selector(cancelActionInSelectView), for: .touchUpInside)
        aView.toolView.comfirmBtn.addTarget(self, action: #selector(comfirmActionInSelectView), for: .touchUpInside)
        return aView
    }()
    @objc func cancelActionInSelectView() {
        selectView.removeFromSuperview()
    }
    @objc func comfirmActionInSelectView() {
        selectView.removeFromSuperview()
        let selectCard = bankDataModel?.list?[selectView.pickView.selectedRow(inComponent: 0)]
        if showCard?.id != selectCard?.id {
            showCard = selectCard
            setCardInfo(card: showCard)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        getUserProfile()
        
        requestWithdrawInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        getBankInfo()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(topView)
        view.addSubview(bottomView)
        view.addSubview(bankView)
        view.addSubview(addBankView)
        view.addSubview(btn)
    }
    
    override func layoutSubView() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        topView.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(80)
        }
        bottomView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.height.equalTo(180)
        }
        bankView.snp.makeConstraints { make in
            make.left.right.equalTo(bottomView)
            make.top.equalTo(bottomView.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        addBankView.snp.makeConstraints { make in
            make.left.right.equalTo(bottomView)
            make.top.equalTo(bottomView.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(bankView.snp.bottom).offset(25)
            make.height.equalTo(44)
        }
    }

    override func bindViewModel() {
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        navView.rightBtn.rx.tap.bind { [unowned self] _ in
            let recordVc = WLWithdrawRecordController()
            self.navigationController?.pushViewController(recordVc, animated: true)
        }.disposed(by: rx.disposeBag)
        bankView.topView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
//                self.view.addSubview(selectView)
//                if let list = bankDataModel?.list, list.count > 0 {
//                    selectView.dataList = list.map({ (data) -> String in
//                        return data.bank_name ?? ""
//                    })
//                }
//                selectView.pickView.reloadAllComponents()
//                selectView.snp.makeConstraints { (make) in
//                    make.edges.equalToSuperview()
//                }
                bankView.topView.icon.isSelected = !bankView.topView.icon.isSelected
                if bankView.topView.icon.isSelected {
                    bankView.selectItem.isHidden = true
                    bankView.tableView.isHidden = false
                    bankView.snp.updateConstraints { make in
                        if bankView.dataList?.count ?? 0 > 2 {
                            make.height.equalTo(150 + 85 + 50)
                        } else {
                            make.height.equalTo(150 + 85*((bankView.dataList?.count ?? 1) - 1))
                        }
                        
                    }
                } else {
                    recoveryBankView()
//                    bankView.selectItem.isHidden = false
//                    bankView.tableView.isHidden = true
//                    bankView.snp.updateConstraints { make in
//                        make.height.equalTo(150)
//                    }
                }
            }.disposed(by: rx.disposeBag)
        //提款
        btn.rx.tap.bind { [unowned self] _ in
            if self.validateInput() {
                withdrawRequest()
            }
        }.disposed(by: rx.disposeBag)
        
        bottomView.tfd.rx.text.orEmpty.skip(1).bind { text in
            let input = text.trimmingCharacters(in: .whitespaces)
            if input.count == 0 {
//                self.bottomView.offlab.isHidden = true
//                self.bottomView.lab2.isHidden = true
                self.bottomView.alertBtn.isHidden = false
            } else {
//                self.bottomView.offlab.isHidden = false
//                self.bottomView.lab2.isHidden = false
                self.bottomView.alertBtn.isHidden = true
            }
            self.bottomView.reallab.text = input
        }.disposed(by: rx.disposeBag)
        addBankView.rx.tap().bind { [weak self] in
            guard let self = self else {
                return
            }
            self.navigator.show(segue: .addBankCard, sender: self)
            
        }.disposed(by: rx.disposeBag)
    }
    
    func recoveryBankView() {
        bankView.selectItem.isHidden = false
        bankView.tableView.isHidden = true
        bankView.snp.updateConstraints { make in
            make.height.equalTo(150)
        }
    }
}
extension WLWithdraw2Controller {
    func getUserProfile() {
        WLProvider.request(.wlUserProfile) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                print(json)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserProfileDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.topView.nameLab.text = dataModel.user_name
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func getBankInfo() {
        WLProvider.request(.wlUserBankBind) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLBankBindDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.bankDataModel = dataModel
                            //如果没有银行卡，就显示新增银行卡页面
                            if dataModel.list?.count ?? 0 > 0 {
                                self.bankView.isHidden = false
                                self.addBankView.isHidden = true
                                //默认显示第一张银行卡信息
                                self.showCard = dataModel.list?.first
                                //展示
                                self.setCardInfo(card: self.showCard)
                                //给银行列表的tableview赋值并刷新
                                self.bankView.dataList = dataModel.list
                            } else {
                                self.bankView.isHidden = true
                                self.addBankView.isHidden = false
                            }
                            
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func requestWithdrawInfo() {
        WLProvider.request(.wlGetWalletWithdraw) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLWalletWithdrawDataModel.init(JSON: json["data"].dictionaryObject ?? [:])  {
                            
                            self.dataModel = dataModel
                            self.setupUIValues()
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
    func setupUIValues() {
        topView.amountLab.text = dataModel?.balance?.divide100().stringValue
        let offAmount = (dataModel?.info?.counter_fee?.doubleValue ?? 0) + (dataModel?.info?.government_fee?.doubleValue ?? 0) - (dataModel?.info?.Discount?.doubleValue ?? 0)
        bottomView.offlab.text = "\(offAmount)"
        
        let min = dataModel?.withdraw_money?.min?.divide100().stringValue ?? ""
        let max = dataModel?.withdraw_money?.max?.divide100().stringValue ?? ""
        bottomView.fanweilab.text = min + " - " + max
        
    }
    func setCardInfo(card: WLBankBindListDataModel?) {
        bankView.selectItem.bank.text = card?.bank_name
        bankView.selectItem.accountName.text = card?.name
        bankView.selectItem.account.text = card?.account
    }
    
    func withdrawRequest() {
        let input = bottomView.tfd.text?.trimmingCharacters(in: .whitespaces)
        let withdrawMoney = NSNumber.init(string: input ?? "0")
        let withdraw = withdrawMoney?.multiply100().int64Value ?? 0
        let cardId = showCard?.id ?? 0
        WLProvider.request(.wlPutWalletWithdraw(withdraw_money: withdraw, withdraw_card: cardId.stringValue)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    self.showHUDMessage(baseModel.message)
                    if baseModel.state == 166 {
                        self.bottomView.tfd.text = ""
                        self.bottomView.reallab.text = ""
                        self.requestWithdrawInfo()
                        
                    } else {
                        
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension WLWithdraw2Controller {
    func validateInput() -> Bool {
        let balance = dataModel?.balance
        let min = dataModel?.withdraw_money?.min?.divide100()
        let max = dataModel?.withdraw_money?.max?.divide100()
        let text = bottomView.tfd.text?.trimmingCharacters(in: .whitespaces)
        let inputNumber = NSNumber.init(string: text ?? "0")
        if (inputNumber?.doubleValue ?? 0) < (min?.doubleValue ?? 0) {
            self.showHUDMessage("withdraw15".wlLocalized + ": \(min ?? 0)")
            return false
        } else if (inputNumber?.doubleValue ?? 0) > (balance?.doubleValue ?? 0) {
            self.showHUDMessage("errorTxt10".wlLocalized)
            return false
        } else if (inputNumber?.doubleValue ?? 0) > (max?.doubleValue ?? 0) {
            self.showHUDMessage("new19".wlLocalized + ": \(max ?? 0)")
            return false
        }
        guard let _ = showCard else {
            self.showHUDMessage("errorTxt11".wlLocalized)
            return false
        }
        return true
    }
}
