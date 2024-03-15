//
//  WLLocalInputField.swift
//  DNYTY
//
//  Created by wulin on 2022/7/1.
//

import UIKit

class WLLocalInputField: ZKView {

    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#D6D9E3")?.cgColor
        return view
    }()
    
    let defaltView = WLLocalInputDefaultField()
    let selectView = WLLocalInputSelectField()
    
    var title: String = "" {
        didSet {
            defaltView.titleLab.text = title
            selectView.titleLab.text = title
        }
    }
    
    let hitIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.hit_b())
        imgV.highlightedImage = RImage.hit_r()
        imgV.isHidden = true
        return imgV
    }()
    
    let eyeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.eye_close(), for: .normal)
        btn.setImage(RImage.eye_open(), for: .selected)
        btn.isHidden = true
        return btn
    }()
    
    let hitLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#E94951")
        lab.font = kMediumFont(12)
        lab.text = "withdraw14".wlLocalized
        lab.isHidden = true
        return lab
    }()
    
    init(title: String? = nil, placeholder: String = "") {
        selectView.textField.placeholder = placeholder
        defaltView.titleLab.text = title
        selectView.titleLab.text = title
        super.init(frame: CGRect())
        selectView.isHidden = true
        addSubview(contentView)
        
        
        addSubview(hitIcon)
        addSubview(hitLab)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(52)
        }
        
        hitIcon.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(contentView.snp.bottom).offset(8)
            make.bottom.equalTo(-8)
        }
        
        hitLab.snp.makeConstraints { make in
            make.left.equalTo(hitIcon.snp.right).offset(4)
            make.centerY.equalTo(hitIcon)
        }
        
        contentView.addSubview(defaltView)
        contentView.addSubview(selectView)
        contentView.addSubview(eyeBtn)
        
        defaltView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(eyeBtn.snp.left).offset(-10)
        }
        
        selectView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(eyeBtn.snp.left).offset(-10)
        }
        
        
        
        eyeBtn.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        let beginEditting = defaltView.rx.tap().map{ true }
        let endEditting = selectView.textField.rx.controlEvent(.editingDidEnd).filter{ [weak self] _ in
            guard let self = self else { return false }
            return self.selectView.textField.text == nil || self.selectView.textField.text!.isEmpty
        }.map{ false }
        let isEditing = beginEditting.merge(with: endEditting)
        
        isEditing.bind(to: defaltView.rx.isHidden).disposed(by: rx.disposeBag)
        isEditing.map{ !$0 }.bind(to: selectView.rx.isHidden).disposed(by: rx.disposeBag)
        isEditing.map{ !$0 }.bind(to: eyeBtn.rx.isHidden).disposed(by: rx.disposeBag)
        
        beginEditting.bind { [weak self] _ in
            guard let self = self else {
                return
            }
            self.selectView.textField.becomeFirstResponder()
        }.disposed(by: rx.disposeBag)
        
        eyeBtn.rx.tap.bind { [weak self] _ in
            guard let self = self else {
                return
            }
            self.eyeBtn.isSelected = !self.eyeBtn.isSelected
            self.selectView.textField.isSecureTextEntry = !self.selectView.textField.isSecureTextEntry
        }.disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class WLLocalInputDefaultField: UIView {
        let titleLab: UILabel = {
            let lab = UILabel()
            lab.textColor = UIColor(hexString: "#72788B")
            lab.font = kMediumFont(14)
            return lab
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(titleLab)
            let xin = UILabel()
            xin.textColor = UIColor(hexString: "#E94951")
            xin.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            xin.text = "*"
            xin.font = kMediumFont(12)
            addSubview(xin)
            
            xin.snp.makeConstraints { make in
                make.left.equalTo(16)
                make.centerY.equalToSuperview().offset(2)
            }
            titleLab.snp.makeConstraints { make in
                make.left.equalTo(xin.snp.right).offset(5)
                make.top.bottom.equalToSuperview()
                make.right.equalTo(-16)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class WLLocalInputSelectField: UIView {
        let titleLab: UILabel = {
            let lab = UILabel()
            lab.textColor = UIColor(hexString: "#72788B")
            lab.font = kMediumFont(12)
            return lab
        }()
        
        let textField: UITextField = {
            let textField = UITextField()
            textField.textColor = UIColor(hexString: "#30333A")
            textField.font = kMediumFont(14)
            textField.setContentHuggingPriority(.defaultLow, for: .vertical)
            textField.autocapitalizationType = .none
            textField.isSecureTextEntry = true
            return textField
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            
            
            let xin = UILabel()
            xin.textColor = UIColor(hexString: "#E94951")
            xin.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            xin.text = "*"
            xin.font = kMediumFont(12)
            addSubview(xin)
            
            addSubview(titleLab)
            addSubview(textField)
            
            xin.snp.makeConstraints { make in
                make.left.equalTo(16)
                make.centerY.equalTo(titleLab.snp.centerY).offset(2)
            }
            
            titleLab.snp.makeConstraints { make in
                make.top.equalTo(9)
                make.left.equalTo(xin.snp.right).offset(5)
            }
            
            textField.snp.makeConstraints { make in
                make.left.equalTo(xin)
                make.right.equalToSuperview()
                make.top.equalTo(titleLab.snp.bottom).offset(2)
                make.bottom.equalTo(-9)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}

extension Reactive where Base: WLLocalInputField {
    typealias ValidationResult1 = ZKHomeServer.ValidationResult
    var validatedResult: Binder<ValidationResult1> {
        Binder(self.base) { view, result in
            switch result {
            case .none(let msg):
                view.hitLab.text = msg
                view.hitIcon.isHighlighted = false
                view.hitIcon.isHidden = msg.isEmpty
                view.hitLab.isHidden = msg.isEmpty
            case .failed(let msg):
                view.hitLab.text = msg
                view.hitIcon.isHighlighted = true
                view.hitIcon.isHidden = false
                view.hitLab.isHidden = false
            default:
                view.hitLab.isHidden = true
                view.hitIcon.isHidden = true
                break
            }
            view.hitLab.textColor = result.textColor
        }
    }
    
    var title: Binder<String> {
        Binder(self.base) { view, title in
            view.title = title
        }
    }
    
    var text: ControlProperty<String?> {
        base.selectView.textField.rx.text
    }
    
    
    var value: ControlProperty<String?> {
        base.selectView.textField.rx.value
    }
}
