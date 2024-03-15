//
//  WLLotteryView.swift
//  NEW
//
//  Created by wulin on 2022/1/20.
//

import UIKit
import WebKit

class WLLotteryHandleView: UIView {

    lazy var countLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = .white
        lab.font = kMediumFont(25)
        lab.layer.cornerRadius = 20
        lab.layer.masksToBounds = true
        lab.textAlignment = .center
        lab.backgroundColor = UIColor.init(hexString: "6442A5")
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "E9C163")
        lab.font = kSystemFont(13)
        lab.text = "lotteryTxt2".wlLocalized
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: 170, height: 50)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [RGB(0, 2, 52).cgColor, RGB(99, 64, 164).cgColor]
        return gradient
    }()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("lotteryTxt3".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(18)
        btn.setBackgroundImage(gradient.snapshotImage(), for: .normal)
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    lazy var refreshBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "shuaxin3"), for: .normal)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(countLab)
        addSubview(titleLab)
        addSubview(startBtn)
        addSubview(refreshBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        countLab.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(10)
            make.width.height.equalTo(40)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(countLab.snp.bottom)
            make.centerX.equalTo(countLab)
            make.width.greaterThanOrEqualTo(60)
        }
        startBtn.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        refreshBtn.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-30)
        }
    }

}
class WLLuckyRuleView: UIView {

    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "2C2C2C")
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        return aView
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "lotteryTxt1".wlLocalized
        lab.textColor = .white
        lab.font = kMediumFont(18)
        lab.textAlignment = .center
        lab.isUserInteractionEnabled = true
        lab.backgroundColor = RGB(100, 66, 165)
        return lab
    }()
    
    private lazy var removeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "guanbi_bai"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    private lazy var textBgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "E8E8E8")
        aView.layer.cornerRadius = 15
        aView.layer.masksToBounds = true
        return aView
    }()
//    lazy var textView: UITextView = {
//        let aView = UITextView.init()
//        aView.textColor = UIColor.init(hexString: "232323")
//        aView.font = RFont.promptMedium(size: 14)
//        aView.backgroundColor = .clear
//        return aView
//    }()
    lazy var webView: WKWebView = {
        let webView = WKWebView.init()
        return webView
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: 160, height: 44)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [RGB(0, 2, 52).cgColor, RGB(99, 64, 164).cgColor]
        return gradient
    }()
    private lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = RGB(54, 55, 149)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = kMediumFont(16)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.setTitle("lotteryTxt10".wlLocalized, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addSubview(bgView)
        bgView.addSubview(titleLab)
        bgView.addSubview(removeBtn)
        bgView.addSubview(textBgView)
        textBgView.addSubview(webView)
        bgView.addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenWidth - 30)
            make.height.equalTo(536)
        }
        titleLab.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(55)
        }
        removeBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleLab)
        }
        
        textBgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.height.equalTo(370)
        }
        webView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(8)
            make.bottom.equalTo(-20)
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(160)
            make.height.equalTo(44)
        }
    }
    
    @objc func btnClick(btn: UIButton) {
        removeFromSuperview()
    }

}
class WLLuckyResultView: UIView {

    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor.init(hexString: "2C2C2C")
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        return aView
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel.init()
        lab.text = "--"
        lab.textColor = .white
        lab.font = kMediumFont(18)
        lab.textAlignment = .center
        lab.isUserInteractionEnabled = true
        lab.backgroundColor = RGB(100, 66, 165)
        return lab
    }()
    
    private lazy var removeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "guanbi_bai"), for: .normal)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    lazy var resultLab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "E9C163")
        lab.font = kMediumFont(18)
        return lab
    }()
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer.init()
        gradient.frame = CGRect.init(x: 0, y: 0, width: 160, height: 44)
        gradient.startPoint = CGPoint.init(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint.init(x: 1.0, y: 0.5)
        gradient.colors = [RGB(0, 2, 52).cgColor, RGB(99, 64, 164).cgColor]
        return gradient
    }()
    private lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = RGB(54, 55, 149)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = kMediumFont(16)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 22
        btn.layer.masksToBounds = true
        btn.setTitle("lotteryTxt10".wlLocalized, for: .normal)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addSubview(bgView)
        bgView.addSubview(titleLab)
        bgView.addSubview(removeBtn)
        bgView.addSubview(resultLab)
        bgView.addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(kScreenWidth - 30)
            make.height.equalTo(210)
        }
        titleLab.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(55)
        }
        removeBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleLab)
        }
        
        
        resultLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(160)
            make.height.equalTo(44)
        }
    }
    
    @objc func btnClick(btn: UIButton) {
        removeFromSuperview()
    }

}
