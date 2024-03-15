//
//  WLLoginViewController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/7.
//

import UIKit

class WLLoginViewController: ZKViewController {
    let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()

    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white"), for: .normal)
        return btn
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "home0".wlLocalized
        lab.textColor = .white
        lab.font = kSystemFont(16)
        return lab
    }()
    private lazy var accountView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login2".wlLocalized
        aView.alertLab.text = "login4".wlLocalized
        return aView
    }()
    private lazy var secretView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login3".wlLocalized
        aView.alertLab.text = "login5".wlLocalized
        aView.btn.isHidden = false
        aView.btn.setImage(UIImage.init(named: "eye_close"), for: .normal)
        aView.btn.setImage(UIImage.init(named: "eye_open"), for: .selected)
        aView.tfd.isSecureTextEntry = true
        return aView
    }()
    private lazy var picCodeView: WLInputWithPicCodeView = {
        let aView = WLInputWithPicCodeView()
        aView.isHidden = true
        return aView
    }()
    private lazy var btnsView: WLLoginBtnsView = {
        let aView = WLLoginBtnsView()
        return aView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "171633")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func initSubView() {
        view.addSubview(closeBtn)
        view.addSubview(titleLab)
        view.addSubview(contentView)
        contentView.addArrangedSubview(accountView)
        contentView.addArrangedSubview(secretView)
        contentView.addArrangedSubview(picCodeView)
        view.addSubview(btnsView)
    }
    
    override func layoutSubView() {
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        
        
        btnsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(contentView.snp.bottom).offset(40)
            make.height.equalTo(120)
        }
        
    }

    override func bindViewModel() {
        closeBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
        
        btnsView.loginBtn.rx.tap.bind { _ in
            
        }.disposed(by: rx.disposeBag)
        btnsView.freeRegisterBtn.rx.tap.bind { _ in
            Navigator.default.show(segue: .register, sender: self)
        }.disposed(by: rx.disposeBag)
        btnsView.forgetAccountBtn.rx.tap.bind { _ in
            Navigator.default.show(segue: .forgetPwd1, sender: self)
        }.disposed(by: rx.disposeBag)
        btnsView.forgetPasswordBtn.rx.tap.bind { _ in
            Navigator.default.show(segue: .forgetPwd1, sender: self)
        }.disposed(by: rx.disposeBag)
        
        
        
        guard let viewModel = viewModel as? ZKLoginViewModel else { return }
        let input = ZKLoginViewModel.Input(account: accountView.tfd.rx.text.orEmpty.asObservable(),
                                           password: secretView.tfd.rx.text.orEmpty.asObservable(),
                                           code: picCodeView.tfd.rx.text.orEmpty.asObservable(),
                                           refreshCode: picCodeView.btn.rx.tap.asObservable(),
                                           loginTap: btnsView.loginBtn.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        output.validatedUsername.drive(accountView.rx.alert).disposed(by: rx.disposeBag)
        output.validatedPassword.drive(secretView.rx.alert).disposed(by: rx.disposeBag)
        output.hideCaptcha.drive(picCodeView.rx.isHidden).disposed(by: rx.disposeBag)
        output.captcha.drive(picCodeView.img.rx.image).disposed(by: rx.disposeBag)
        
        output.loginSucceed.drive { result in
            if result {
                UIApplication.appDeltegate.presentInitialScreen()
            }
            
            
        }.disposed(by:rx.disposeBag)
        
        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
    }

}
