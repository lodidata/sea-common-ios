//
//  WLForgetPwd1Controller.swift
//  DNYTY
//
//  Created by wulin on 2022/6/8.
//

import UIKit

class WLForgetPwd1Controller: ZKViewController {

    private lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "close_white"), for: .normal)
        return btn
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.text = "login30".wlLocalized
        lab.textColor = .white
        lab.font = kSystemFont(16)
        return lab
    }()
    private lazy var phoneView: WLInfoInputInfoView = {
        let aView = WLInfoInputInfoView()
        aView.titleLab.text = "login10".wlLocalized
        aView.alertLab.text = "login18".wlLocalized
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
    lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login19".wlLocalized, for: .normal)
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
        view.addSubview(closeBtn)
        view.addSubview(titleLab)
        view.addSubview(phoneView)
        view.addSubview(nextBtn)
        view.addSubview(backBtn)
    }
    
    override func layoutSubView() {
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.top.equalTo(view.safeAreaInsets.top).offset(25)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
        }
        phoneView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(25)
            
        }
        nextBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(phoneView.snp.bottom).offset(20)
            make.height.equalTo(45)
        }
        backBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(nextBtn.snp.bottom).offset(10)
            make.height.equalTo(45)
        }
    }

    override func bindViewModel() {
        closeBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
//        nextBtn.rx.tap.bind {[weak self] _ in
//            guard let self = self else {
//                return
//            }
//            Navigator.default.show(segue: .forgetPwd2(phone: self.phoneView.tfd.text ?? ""), sender: self)
//        }.disposed(by: rx.disposeBag)
        backBtn.rx.tap.bind { _ in
            Navigator.default.pop(sender: self)
        }.disposed(by: rx.disposeBag)
        
        guard let viewModel = self.viewModel as? ZKForgetPsw1ViewModel else { return }
        
        let input = ZKForgetPsw1ViewModel.Input(account: phoneView.tfd.rx.text.orEmpty.asObservable(),
                                                getCodeTap: nextBtn.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        output.valitionAccount.drive(phoneView.rx.alert).disposed(by: rx.disposeBag)
        output.sendCodeResult.drive {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .respone:
                
                Navigator.default.show(segue: .forgetPwd2(phone: self.phoneView.tfd.text ?? ""), sender: self)
            case .failed(let message):
                DefaultWireFrame.showPrompt(text: message)
            }
            
            
        }.disposed(by: rx.disposeBag)
        
        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
    }
}
