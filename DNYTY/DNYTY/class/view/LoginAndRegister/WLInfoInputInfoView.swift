//
//  WLInfoInputInfoView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/7.
//

import UIKit


class WLInfoInputInfoView: UIView {

    lazy var flag: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text = "*"
        return lab
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    let bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "28273E")
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        aView.layer.borderWidth = 1
        aView.layer.borderColor = UIColor.init(hexString: "39375A")?.cgColor
        return aView
    }()
    lazy var tfd: UITextField = {
        let tfd = UITextField.init()
        tfd.textColor = .white
        tfd.font = UIFont.systemFont(ofSize: 14)
        tfd.autocapitalizationType = .none
        return tfd
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.isHidden = true
        return btn
    }()
    
    lazy var alertLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.init(hexString: "72788B")
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(flag)
        addSubview(titleLab)
        addSubview(bgView)
        bgView.addSubview(tfd)
        bgView.addSubview(btn)
        addSubview(alertLab)
        
        makeUI()
        
        btn.rx.tap.bind { [weak self] in
            guard let self = self else { return  }
            self.btn.isSelected = !self.btn.isSelected
            self.tfd.isSecureTextEntry = !self.tfd.isSecureTextEntry
        }.disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI () {
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(flag.snp.right).offset(5)
            
        }
        flag.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(titleLab.snp.centerY).offset(3)
        }
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(titleLab.snp.bottom).offset(8)
            make.right.equalTo(-15)
            make.height.equalTo(45)
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        tfd.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.centerY.equalToSuperview()
            make.right.equalTo(btn.snp.left).offset(-10)
        }
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(bgView.snp.bottom).offset(8)
            make.bottom.equalTo(-5)
        }
    }
}

extension Reactive where Base: WLInfoInputInfoView {
    var alert: Binder<ZKLoginViewModel.ValidationResult> {
        Binder(self.base){ view, result in
            view.alertLab.textColor = result.textColor
            switch result {
            case .ok:
                view.alertLab.text = ""
                view.bgView.layer.borderColor = UIColor(hexString: "39375A")?.cgColor
            case .failed(let msg):
                view.bgView.layer.borderColor = UIColor(hexString: "#E94951")?.cgColor
                view.alertLab.text = msg
            case .none(let msg):
                view.alertLab.text = msg
                view.bgView.layer.borderColor = UIColor(hexString: "39375A")?.cgColor
            }
        }
    }
}

class WLInfoPhoneForCodeView: UIView {

    lazy var flag: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.text = "*"
        return lab
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }()
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "28273E")
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        aView.layer.borderWidth = 1
        aView.layer.borderColor = UIColor.init(hexString: "39375A")?.cgColor
        return aView
    }()
    lazy var customView: WlBtnArrowView = {
        let aView = WlBtnArrowView.init()
        return aView
    }()
    lazy var phoneCodeLab: UILabel = {
        let lab = UILabel.init()
        lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.white
        lab.text = "+63"
        return lab
    }()
    lazy var tfd: UITextField = {
        let tfd = UITextField.init()
        tfd.textColor = .white
        tfd.font = UIFont.systemFont(ofSize: 14)
        tfd.autocapitalizationType = .none
        return tfd
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: 110, height: 45)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [UIColor.init(hexString: "1C2259")!.cgColor, UIColor.init(hexString: "B22EA8")!.cgColor]
        return gradient
    }()
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("login11".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.numberOfLines = 2
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    
    lazy var alertLab: UILabel = {
        let lab = UILabel.init()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = UIColor.init(hexString: "72788B")
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(flag)
        addSubview(titleLab)
        addSubview(bgView)
        bgView.addSubview(customView)
        bgView.addSubview(phoneCodeLab)
        bgView.addSubview(tfd)
        addSubview(btn)
        addSubview(alertLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flag.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(5)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(flag.snp.right).offset(8)
            make.centerY.equalTo(flag)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
            make.right.equalTo(-135)
            make.height.equalTo(45)
        }
        customView.snp.makeConstraints { make in
            make.left.equalTo(3)
            make.centerY.equalToSuperview()
            //make.width.equalTo(40)
            make.height.equalTo(35)
        }
        phoneCodeLab.snp.makeConstraints { make in
            make.left.equalTo(customView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        tfd.snp.makeConstraints { make in
            make.left.equalTo(phoneCodeLab.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalTo(-10)
        }
        btn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalTo(bgView)
            make.width.equalTo(110)
            make.height.equalTo(45)
        }
        
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(flag)
            make.top.equalTo(bgView.snp.bottom).offset(5)
        }
    }
}

class WlBtnArrowView: UIView {
    
    lazy var img: UIImageView = {
        let img = UIImageView.init()
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        img.image = UIImage.init(named: "lan_flag_en")
        img.contentMode = .center
        return img
    }()
    lazy var flag: UIImageView = {
        let img = UIImageView.init()
        img.image = UIImage.init(named: "arrow_down_white")
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "39375A")
        addSubview(img)
        addSubview(flag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.centerY.equalToSuperview()
        }
//        flag.snp.makeConstraints { make in
//            make.right.equalTo(-5)
//            make.centerY.equalToSuperview()
//        }
    }
}
