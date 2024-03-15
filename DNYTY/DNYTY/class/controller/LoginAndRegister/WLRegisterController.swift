//
//  WLRegisterController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/7.
//

import UIKit

class WLRegisterController: ZKScrollViewController {

    
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = UIImage.init(named: "banner_register")
        return img
    }()
    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white"), for: .normal)
        return btn
    }()
    private lazy var accountView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "massage0".wlLocalized
        aView.alertLab.text = "login6".wlLocalized
        return aView
    }()
    private lazy var secretView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login3".wlLocalized
        aView.alertLab.text = "login7".wlLocalized
        aView.btn.isHidden = false
        aView.btn.setImage(UIImage.init(named: "eye_close"), for: .normal)
        aView.btn.setImage(UIImage.init(named: "eye_open"), for: .selected)
        aView.tfd.isSecureTextEntry = true
        return aView
    }()
    private lazy var comfirmSecretView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login8".wlLocalized
        aView.alertLab.text = "login9".wlLocalized
        aView.btn.isHidden = false
        aView.btn.setImage(UIImage.init(named: "eye_close"), for: .normal)
        aView.btn.setImage(UIImage.init(named: "eye_open"), for: .selected)
        aView.tfd.isSecureTextEntry = true
        return aView
    }()
    private lazy var phoneCodeView: WLInfoPhoneForCodeView = {
        let aView = WLInfoPhoneForCodeView()
        aView.titleLab.text = "login10".wlLocalized
        return aView
    }()
    private lazy var codeView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login12".wlLocalized
        aView.alertLab.text = "login13".wlLocalized
        return aView
    }()
    private lazy var recommendView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login14".wlLocalized
        aView.alertLab.text = ""
        return aView
    }()
    private lazy var btnsView: WLRegisterAlertView = {
        let aView = WLRegisterAlertView()
        return aView
    }()
//    private lazy var codeListView: WLRegisterPhoneCodeListView = {
//        let aView = WLRegisterPhoneCodeListView.init()
//        aView.isHidden = true
//        return aView
//    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = WLRegisterViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "171633")
    }
    
    override func initSubView() {
        super.initSubView()
        contentView.addSubview(img)
        contentView.addSubview(closeBtn)
        contentView.addSubview(accountView)
        contentView.addSubview(secretView)
        contentView.addSubview(comfirmSecretView)
        contentView.addSubview(phoneCodeView)
        contentView.addSubview(codeView)
        contentView.addSubview(recommendView)
        contentView.addSubview(btnsView)
        //contentView.addSubview(codeListView)
    }
    override func layoutSubView() {
        super.layoutSubView()
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        img.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(155)
            make.width.equalTo(kScreenWidth)
        }
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(20)
            make.right.equalTo(-12)
            make.width.height.equalTo(20)
        }
        accountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(closeBtn.snp.bottom).offset(10)
            
        }
        secretView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(accountView.snp.bottom).offset(15)
            
        }
        comfirmSecretView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(secretView.snp.bottom).offset(20)
            
        }
        phoneCodeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(comfirmSecretView.snp.bottom).offset(15)
            make.height.equalTo(70)
        }
//        codeListView.snp.makeConstraints { make in
//            make.left.equalTo(15)
//            make.right.equalTo(-15)
//            make.top.equalTo(phoneCodeView.snp.bottom)
//            make.height.equalTo(200)
//        }
        codeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneCodeView.snp.bottom).offset(15)
            
        }
        recommendView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(codeView.snp.bottom).offset(15)
            
        }
        btnsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(recommendView.snp.bottom).offset(10)
            make.height.equalTo(160)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func bindViewModel() {
        btnsView.btn.rx.tap.bind { [weak self] in
            guard let self = self else { return  }
            self.navigator.show(segue: .h5(page: .helpUserPolicy), sender: self)
        }.disposed(by: rx.disposeBag)
        
        closeBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
//        phoneCodeView.customView.rx.tap().bind { [unowned self] _ in
//            self.codeListView.isHidden = !codeListView.isHidden
//        }.disposed(by: rx.disposeBag)
        
        
        guard let viewModel = viewModel as? WLRegisterViewModel else {
            return
        }
        let input = WLRegisterViewModel.Input(accountOb: accountView.tfd.rx.text.orEmpty.asObservable(),
                                              pwdOb: secretView.tfd.rx.text.orEmpty.asObservable(),
                                              comfirmPwdOb: comfirmSecretView.tfd.rx.text.orEmpty.asObservable(),
                                              phoneOb: phoneCodeView.tfd.rx.text.orEmpty.asObservable(),
                                              invitCodeOb: recommendView.tfd.rx.text.orEmpty.asObservable(),
                                              getCodeOb: phoneCodeView.btn.rx.tap.asObservable(),
                                              codeOb: codeView.tfd.rx.text.orEmpty.asObservable(),
                                              recommendOb: recommendView.tfd.rx.text.orEmpty.asObservable(),
                                              protocolisSelectOb: btnsView.flagBtn.rx.tap.map{ [unowned self] in return self.btnsView.flagBtn.isSelected }.startWith(false),
                                              protocolClickOb: btnsView.btn.rx.tap.asObservable(),
                                              registerOb:
                                                btnsView.registerBtn.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        output.validatedUsername.drive(accountView.rx.alert).disposed(by: rx.disposeBag)
        output.validatedPassword.drive(secretView.rx.alert).disposed(by: rx.disposeBag)
        output.validatedRepeated.drive(comfirmSecretView.rx.alert).disposed(by: rx.disposeBag)
        //output.phoneValid.bind(to: phoneCodeView.alertLab.rx.isHidden).disposed(by: rx.disposeBag)
        output.getOtpText.drive(phoneCodeView.btn.rx.title(for: .normal)).disposed(by: rx.disposeBag)
        output.getOtpEnable.drive(phoneCodeView.btn.rx.isUserInteractionEnabled).disposed(by: rx.disposeBag)
        output.protocolOK.drive(btnsView.lab2.rx.isHidden).disposed(by: rx.disposeBag)
        output.registerResult.drive{ result in
            
            switch result {
            case .ok(let info):
                ZKLoginUser.shared.save(model: ZKUserModel(uuid: info.uuid, token: info.token))
                self.navigator.pop(sender: self)
                DefaultWireFrame.showPrompt(text: "new24".wlLocalized)
            case .failed(let msg):
                DefaultWireFrame.showPrompt(text: msg)
            }
            
        }.disposed(by: rx.disposeBag)
    }

}
