//
//  WLProfileController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLProfileController: ZKViewController {

    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = "account7".wlLocalized
        aView.rightBtn.isHidden = true
        return aView
    }()
    private lazy var pswView: WLLabBtnView = {
        let aView = WLLabBtnView()
        aView.lab.text = "new_psd0".wlLocalized
        aView.btn.setImage(UIImage.init(named: "arrow_right_purple"), for: .normal)
        return aView
    }()
    private lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    private lazy var accountView: WLTfdBtnWithTitleView = {
        let aView = WLTfdBtnWithTitleView()
        aView.titleLab.text = "massage0".wlLocalized
        aView.tfd.placeholder = "login4".wlLocalized
        return aView
    }()
    private lazy var nameView: WLTfdBtnWithTitleView = {
        let aView = WLTfdBtnWithTitleView()
        aView.titleLab.text = "massage1".wlLocalized
        aView.tfd.placeholder = "massage4".wlLocalized
        return aView
    }()
    private lazy var phoneView: WLPhoneShowView = {
        let aView = WLPhoneShowView()
        return aView
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 80, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("massage3".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        btn.setTitleColor(.white, for: .normal)
        btn.isHidden = true
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        getUserProfile()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(pswView)
        view.addSubview(bgView)
        bgView.addSubview(accountView)
        bgView.addSubview(nameView)
        bgView.addSubview(phoneView)
        bgView.addSubview(btn)
    }
    
    override func layoutSubView() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        pswView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(navView.snp.bottom).offset(15)
            make.height.equalTo(52)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalTo(pswView)
            make.top.equalTo(pswView.snp.bottom).offset(10)
            make.bottom.equalTo(-15)
        }
        accountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(10)
            make.height.equalTo(70)
        }
        nameView.snp.makeConstraints { make in
            make.left.right.height.equalTo(accountView)
            make.top.equalTo(accountView.snp.bottom)
        }
        phoneView.snp.makeConstraints { make in
            make.left.right.equalTo(accountView)
            make.top.equalTo(nameView.snp.bottom)
            make.height.equalTo(87)
        }
        btn.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(phoneView.snp.bottom).offset(40)
            make.height.equalTo(45)
        }
    }
    
    override func bindViewModel() {
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        
        pswView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                let vc = WLSetPswController()
                self.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: rx.disposeBag)
        
        //真实姓名的编辑按钮
        nameView.btn.rx.tap
            .bind { [unowned self] _ in
                nameView.tfd.isEnabled = true
                nameView.tfd.text = ""
                btn.isHidden = false
            }.disposed(by: rx.disposeBag)
        //保存
        btn.rx.tap
            .bind { [unowned self] _ in
                if let name = nameView.tfd.text {
                    saveUserProfile(name: name)
                }
            }.disposed(by: rx.disposeBag)
        
    }

}
extension WLProfileController {
    func getUserProfile() {
        WLProvider.request(.wlUserProfile) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLUserProfileDataModel.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            if let username = dataModel.user_name {
                                self.accountView.tfd.text = username
                            }
                            if let trueName = dataModel.true_name, trueName.count > 0 {
                                self.nameView.tfd.text = trueName
                                self.nameView.btn.isHidden = true
                                self.nameView.tfd.isEnabled = false
                            } else {
                                self.nameView.tfd.text = "massage5".wlLocalized
                                self.nameView.btn.isHidden = false
                            }
                            //手机号
                            self.phoneView.phoneCodeLab.text = "+63 " + dataModel.mobile
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveUserProfile(name: String) {
        WLProvider.request(.wlbaseInfo(name: name)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.showHUDMessage("new7".wlLocalized)
                        self.getUserProfile()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
