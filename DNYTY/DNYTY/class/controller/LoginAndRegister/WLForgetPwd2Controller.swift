//
//  WLForgetPwd2Controller.swift
//  DNYTY
//
//  Created by wulin on 2022/6/8.
//

import UIKit

class WLForgetPwd2Controller: ZKViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        return scrollView
    }()
    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white"), for: .normal)
        return btn
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "login34".wlLocalized
        lab.textColor = .white
        lab.font = kSystemFont(16)
        return lab
    }()
    private lazy var codeView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login12".wlLocalized
        aView.alertLab.text = "login21".wlLocalized
        return aView
    }()
    private lazy var newPwdView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login22".wlLocalized
        aView.alertLab.text = "login23".wlLocalized
        return aView
    }()
    private lazy var comfirmPwdView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login24".wlLocalized
        aView.alertLab.text = "login9".wlLocalized
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
    lazy var modifyBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login25".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    lazy var backBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login20".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = UIColor.init(hexString: "39375A")
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "171633")
    }
    
    override func initSubView() {
        view.addSubview(scrollView)
        scrollView.addSubview(closeBtn)
        scrollView.addSubview(titleLab)
        scrollView.addSubview(codeView)
        scrollView.addSubview(newPwdView)
        scrollView.addSubview(comfirmPwdView)
        scrollView.addSubview(modifyBtn)
        scrollView.addSubview(backBtn)
    }
    
    override func layoutSubView() {
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenWidth)
        }
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.top.equalTo(view.safeAreaInsets.top).offset(25)
            make.width.height.equalTo(20)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(64)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        codeView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(100)
            make.width.equalTo(kScreenWidth)
        }
        newPwdView.snp.makeConstraints { make in
            make.left.right.equalTo(codeView)
            make.top.equalTo(codeView.snp.bottom).offset(20)
        }
        comfirmPwdView.snp.makeConstraints { make in
            make.left.right.equalTo(codeView)
            make.top.equalTo(newPwdView.snp.bottom).offset(20)
        }
        modifyBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(comfirmPwdView.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(modifyBtn.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.bottom.equalTo(-60)
        }
    }
    
    override func bindViewModel() {
        closeBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
        backBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKForgetPsw2ViewModel else {
            return
        }
        let input = ZKForgetPsw2ViewModel.Input(code: codeView.tfd.rx.text.orEmpty.asObservable(),
                                                password: newPwdView.tfd.rx.text.orEmpty.asObservable(),
                                                repeatedPsd: comfirmPwdView.tfd.rx.text.orEmpty.asObservable(),
                                                nextTap: modifyBtn.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.valitionCode.drive(codeView.rx.alert).disposed(by: rx.disposeBag)
        output.validatedPassword.drive(newPwdView.rx.alert).disposed(by: rx.disposeBag)
        output.validatedRepeated.drive(comfirmPwdView.rx.alert).disposed(by: rx.disposeBag)
        
        
        output.changeResult.drive {[weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .respone:
                DefaultWireFrame.showPrompt(text: "new_psd8".wlLocalized)
                self.navigator.pop(sender: self, toRoot: true)
                self.navigator.show(segue: .login, sender: self)
            case .failed(let message):
                DefaultWireFrame.showPrompt(text: message)
            }
        }.disposed(by: rx.disposeBag)
        
        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
        
    }

}
