//
//  ZKLocalInputView.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit
import YYText
import RxCocoa

class ZKLocalInputView: ZKView {
    
    //客服
    var kefuTap: PublishRelay<Void> = PublishRelay()

    let textLab: YYLabel = {
       let lab = YYLabel()
        lab.preferredMaxLayoutWidth = kScreenWidth - 64
        lab.textColor = UIColor(hexString: "#72788B")
        lab.numberOfLines = 0
        lab.font = kMediumFont(12)
        lab.text = "please use the gcash that linked with your registerred mobile no. to transfer funds. afer deposit, please submit the order as soon as possibie after recharging. the system will automatically add the credit in1-3 minutes."
        return lab
    }()
    
    let bankField: ZKLocalInputField = {
        let view = ZKLocalInputField(title: "recharge28".wlLocalized)
        view.mordIcon.isHidden = false
        view.defaltView.isUserInteractionEnabled = false
        return view
    }()
    
    let bankAccountField: ZKLocalInputField =  {
        let view = ZKLocalInputField(title: "recharge29".wlLocalized)
        view.contentView.isUserInteractionEnabled = false
        return view
    }()
    
    let nameField: ZKLocalInputField = ZKLocalInputField(title: "recharge30".wlLocalized, placeholder: "recharge30".wlLocalized)
    
    let moneyField: ZKLocalInputField = {

        let view = ZKLocalInputField(title: "recharge31".wlLocalized, placeholder: "recharge31".wlLocalized)
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    let dateSelectItems = ZKDateSelectButtonView()
    
    let submitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bgl = kSubmitButtonLayer1(size: CGSize(width: 323, height: 44))
        bgl.cornerRadius = 5
        btn.setBackgroundImage(bgl.snapshotImage(), for: .normal)
        btn.setTitle("recharge35".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(16)
        
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override func makeUI() {
        backgroundColor = .white
        layer.cornerRadius = 5
        addSubview(textLab)
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line)
        addSubview(bankField)
        addSubview(bankAccountField)
        addSubview(nameField)
        addSubview(moneyField)
        addSubview(dateSelectItems)
        addSubview(submitBtn)
        
        textLab.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(16)
            make.right.equalTo(-16)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.height.equalTo(1)
            make.top.equalTo(textLab.snp.bottom).offset(16)
        }
        
        bankField.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(line.snp.bottom).offset(16)
            //make.bottom.equalTo(-20)
        }
        
        bankAccountField.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(bankField.snp.bottom)
        }
        nameField.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(bankAccountField.snp.bottom)
        }
        moneyField.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(nameField.snp.bottom)
        }

        dateSelectItems.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(moneyField.snp.bottom)
        }

        submitBtn.snp.makeConstraints { make in
            make.left.right.equalTo(textLab)
            make.top.equalTo(dateSelectItems.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        
        let attrStr = NSMutableAttributedString(string:"please use the gcash that linked with your registerred mobile no. to transfer funds. afer deposit, please submit the order as soon as possibie after recharging. the system will automatically add the credit in1-3 minutes.contact online customer service")
        attrStr.yy_font = kMediumFont(12)
        attrStr.yy_color = UIColor(hexString: "#72788B")

        let range = NSRange(attrStr.string.range(of: "contact online customer service")!, in: attrStr.string)
        //下划线
        let textDecoration = YYTextDecoration(style: .single)
        attrStr .yy_setTextUnderline(textDecoration, range: range)
        
        attrStr.yy_setTextHighlight(range, color: UIColor(hexString: "32c5ff"), backgroundColor: nil) {[unowned self] _, _, _, _ in
            self.kefuTap.accept(())
        }
        
        textLab.attributedText = attrStr
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class ZKLocalInputField: ZKView {
    
    
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#D6D9E3")?.cgColor
        return view
    }()
    
    let defaltView = ZKLocalInputDefaultField()
    private let selectView = ZKLocalInputSelectField()
    
    var title: String = "" {
        didSet {
            defaltView.titleLab.text = title
            selectView.titleLab.text = title
        }
        
        
    }
    
    
    
//    let titleLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor(hexString: "#72788B")
//        lab.font = kMediumFont(12)
//        return lab
//    }()
//    let textField: UITextField = {
//        let textField = UITextField()
//        textField.textColor = UIColor(hexString: "#30333A")
//        textField.font = kMediumFont(14)
//        return textField
//    }()
    let hitIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.hit_b())
        imgV.highlightedImage = RImage.hit_r()
        imgV.isHidden = true
        return imgV
    }()
    
    let mordIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.h_ljt())
        imgV.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imgV.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        imgV.isHidden = true
        return imgV
    }()
    
    let hitLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#E94951")
        lab.font = kMediumFont(12)
        lab.text = "withdraw14".wlLocalized
        lab.isHidden = true
        return lab
    }()
    
    var textField: UITextField {
        self.selectView.textField
    }
    
    var text: String? {
        set {
            self.selectView.textField.text = newValue
            self.selectView.isHidden = self.selectView.textField.text?.isEmpty ?? true
            self.defaltView.isHidden = !(self.selectView.textField.text?.isEmpty ?? true)
        }
        get {
            self.selectView.textField.text
            
        }
    }
    
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
        contentView.addSubview(mordIcon)
        
        defaltView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(mordIcon.snp.left).offset(-10)
        }
        
        selectView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(mordIcon.snp.left).offset(-10)
        }
        
        
        
        mordIcon.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        let beginEditting = defaltView.rx.tap().map{ true }
        let endEditting = selectView.textField.rx.controlEvent(.editingDidEnd).map{ false }
        let isEditing = beginEditting.merge(with: endEditting)
        
        
        
        
        isEditing.bind { [weak self] isEditing in
            guard let self = self else {
                return
            }
            if isEditing {
                self.becomeFirstResponder()
            } else {
                self.resignFirstResponder()
            }
        }.disposed(by: rx.disposeBag)
        
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        self.selectView.isHidden = false
        self.defaltView.isHidden = true
        self.selectView.textField.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        self.selectView.isHidden = self.selectView.textField.text?.isEmpty ?? true
        self.defaltView.isHidden = !(self.selectView.textField.text?.isEmpty ?? true)
        self.selectView.textField.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class ZKLocalInputDefaultField: UIView {
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
    
    class ZKLocalInputSelectField: UIView {
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

extension Reactive where Base: ZKLocalInputField {
    typealias ValidationResult = ZKHomeServer.ValidationResult
    var validatedResult: Binder<ValidationResult> {
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
        let source = base.textField.rx.text.asObservable()
        let binder = Binder<String?>(base) { view, text in
            view.text = text
        }
        
        return ControlProperty(values: source, valueSink: binder)
    }
    
    
    var value: ControlProperty<String?> {
        base.textField.rx.value
    }
}

class ZKDateSelectButtonView: ZKView {
    let dateBtn: ZKDateSelectButton = {
        let btn = ZKDateSelectButton()
        
        return btn
    }()
    
    let hourBtn: ZKDateSelectButton = {
        let btn = ZKDateSelectButton()
        btn.icon.isHidden = true
        return btn
    }()
    
    let minuteBtn: ZKDateSelectButton = {
        let btn = ZKDateSelectButton()
        btn.icon.isHidden = true
        return btn
    }()
    
    override func makeUI() {
        addSubview(dateBtn)
        addSubview(hourBtn)
        addSubview(minuteBtn)
        
        dateBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        hourBtn.snp.makeConstraints { make in
            make.left.equalTo(dateBtn.snp.right).offset(5)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(dateBtn.snp.width).multipliedBy(0.5)
        }
        
        minuteBtn.snp.makeConstraints { make in
            make.left.equalTo(hourBtn.snp.right).offset(5)
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(hourBtn.snp.width)
        }
    }
}

class ZKDateSelectButton: ZKView {
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 2
        lab.adjustsFontSizeToFitWidth = true
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge32".wlLocalized
        return lab
    }()
    
    let textLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        lab.adjustsFontSizeToFitWidth = true
        lab.text = "recharge32".wlLocalized
        return lab
    }()
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.date_icon1())
        
        return imgV
    }()
    
    override func makeUI() {
        
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#D6D9E3")?.cgColor
        
        addSubview(titleLab)
        addSubview(textLab)
        addSubview(icon)
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(9)
            make.right.lessThanOrEqualTo(-10)
        }
        
        textLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(8)
            make.left.equalTo(titleLab)
            make.bottom.equalTo(-8)
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalTo(-14)
            make.centerY.equalTo(textLab.snp.centerY)
        }
        
    }
}
