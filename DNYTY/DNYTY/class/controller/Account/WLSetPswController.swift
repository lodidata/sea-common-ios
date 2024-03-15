//
//  WLSetPswController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLSetPswController: ZKViewController {

    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = "新密码"
        aView.rightBtn.isHidden = true
        return aView
    }()
//    private lazy var oldpwdView: WLSetPswView = {
//        let aView = WLSetPswView()
//        aView.titleLab.text = "旧密码"
//        aView.tfd.placeholder = "请输入旧密码"
//        return aView
//    }()
//    private lazy var newpwdView: WLSetPswView = {
//        let aView = WLSetPswView()
//        aView.titleLab.text = "新密码"
//        aView.tfd.placeholder = "请输入新密码"
//        return aView
//    }()
//    private lazy var comfirmNewpwdView: WLSetPswView = {
//        let aView = WLSetPswView()
//        aView.titleLab.text = "确认新密码"
//        aView.tfd.placeholder = "请确认新密码"
//        return aView
//    }()
    
    let oldpwdView: WLLocalInputField = {
        let view = WLLocalInputField(title: "new_psd1".wlLocalized)
        view.contentView.backgroundColor = .white
        view.hitIcon.isHidden = false
        view.hitLab.isHidden = false
        view.hitLab.textColor = UIColor(hexString: "#72788B")
        view.hitLab.text = "new3".wlLocalized
        return view
    }()
    let newpwdView: WLLocalInputField = {
        let view = WLLocalInputField(title: "new_psd2".wlLocalized)
        view.contentView.backgroundColor = .white
        view.hitIcon.isHidden = false
        view.hitLab.isHidden = false
        view.hitLab.textColor = UIColor(hexString: "#72788B")
        view.hitLab.text = "new3".wlLocalized
        return view
    }()
    let comfirmNewpwdView: WLLocalInputField = {
        let view = WLLocalInputField(title: "new_psd3".wlLocalized)
        view.contentView.backgroundColor = .white
        view.hitIcon.isHidden = false
        view.hitLab.isHidden = false
        view.hitLab.textColor = UIColor(hexString: "#72788B")
        view.hitLab.text = "login9".wlLocalized
        return view
    }()
    
    
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth - 30, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "5767FD")!.cgColor, UIColor.init(hexString: "B030AB")!.cgColor]
        return gradient
    }()
    lazy var updateBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("new_psd7".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
    }
    
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(oldpwdView)
        view.addSubview(newpwdView)
        view.addSubview(comfirmNewpwdView)
        view.addSubview(updateBtn)
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        oldpwdView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(navView.snp.bottom).offset(15)
            make.height.equalTo(80)
        }
        newpwdView.snp.makeConstraints { make in
            make.left.right.equalTo(oldpwdView)
            make.top.equalTo(oldpwdView.snp.bottom)
            make.height.equalTo(oldpwdView)
        }
        comfirmNewpwdView.snp.makeConstraints { make in
            make.left.right.equalTo(oldpwdView)
            make.top.equalTo(newpwdView.snp.bottom)
            make.height.equalTo(oldpwdView)
        }
        updateBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(comfirmNewpwdView.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func bindViewModel() {
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        
//        oldpwdView.tfd.rx.text.orEmpty.bind { text in
//            let input = text.trimmingCharacters(in: .whitespacesAndNewlines)
//            if input.count >= 6 && input.count <= 16 {
//                self.oldpwdView.alertBtn.isHidden = true
//            } else {
//                self.oldpwdView.alertBtn.isHidden = false
//            }
//        }.disposed(by: rx.disposeBag)
//        newpwdView.tfd.rx.text.orEmpty.bind { text in
//            let input = text.trimmingCharacters(in: .whitespacesAndNewlines)
//            if input.count >= 6 && input.count <= 16 {
//                self.newpwdView.alertBtn.isHidden = true
//            } else {
//                self.newpwdView.alertBtn.isHidden = false
//            }
//        }.disposed(by: rx.disposeBag)
//        comfirmNewpwdView.tfd.rx.text.orEmpty.bind { text in
//            let input = text.trimmingCharacters(in: .whitespacesAndNewlines)
//            if input.count >= 6 && input.count <= 16 {
//                self.comfirmNewpwdView.alertBtn.isHidden = true
//            } else {
//                self.comfirmNewpwdView.alertBtn.isHidden = false
//            }
//        }.disposed(by: rx.disposeBag)
        
        
        updateBtn.rx.tap.bind { [unowned self] _ in
            if inputValidate() {
                modifySecret()
            }
        }.disposed(by: rx.disposeBag)
    }
    func inputValidate() -> Bool {
        let old = oldpwdView.selectView.textField.text ?? ""
        let new = newpwdView.selectView.textField.text ?? ""
        let comfirm = comfirmNewpwdView.selectView.textField.text ?? ""
        if old.count < 1 {
            self.showHUDMessage("new_psd5".wlLocalized)
            return false
        }
        if new.count < 6 || old.count > 16 {
            self.showHUDMessage("new_psd2".wlLocalized + "new3".wlLocalized)
            return false
        }
        if new != comfirm {
            self.showHUDMessage("new_psd4".wlLocalized)
            return false
        }
        let reg = "^[a-zA-Z0-9]+$"
        let pre = NSPredicate(format: "SELF MATCHES %@", reg)
        if !pre.evaluate(with: new) {
            self.showHUDMessage("new_psd2".wlLocalized + "new3".wlLocalized)
            return false
        }
        return true
    }
}

extension WLSetPswController {
    func modifySecret() {
        WLProvider.request(.wlSafetyLoginpwd(password_old: oldpwdView.selectView.textField.text ?? "", password_new: newpwdView.selectView.textField.text ?? "", repassword_new: comfirmNewpwdView.selectView.textField.text ?? "")) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    //返回状态 1002 成功，并退出登录
                    if baseModel.state == 1002 {
                        DefaultWireFrame.showPrompt(text: "new_psd8".wlLocalized)
                        ZKLoginUser.shared.clean()
                        UIApplication.appDeltegate.presentInitialScreen()
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
