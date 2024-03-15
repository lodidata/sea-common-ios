//
//  WLWithdrawQueryAlphaView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/24.
//

import UIKit

class WLWithdrawQueryAlphaView: UIView {

    lazy var topView: WLWithdrawQueryView = {
        let aView = WLWithdrawQueryView()
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.15)
        addSubview(topView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }

}
class WLWithdrawQueryView: UIView {
    
    lazy var startView: WLDateSelectItemView = {
        let aView = WLDateSelectItemView()
        aView.lab.text = "new4".wlLocalized
        return aView
    }()
    lazy var endView: WLDateSelectItemView = {
        let aView = WLDateSelectItemView()
        aView.lab.text = "new5".wlLocalized
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
    private lazy var icon: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.image = UIImage.init(named: "tanhao_gray")
        return img
    }()
    private lazy var alertLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.text = "finance10".wlLocalized
        return lab
    }()
    lazy var queryBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("finance6".wlLocalized, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.layer.addSublayer(gradient)
        btn.bringSubviewToFront(btn.titleLabel!)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(startView)
        addSubview(endView)
        addSubview(icon)
        addSubview(alertLab)
        addSubview(queryBtn)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        startView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.width.equalTo((kScreenWidth - 40) / 2)
            make.height.equalTo(54)
        }
        endView.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.width.height.equalTo(startView)
        }
        icon.snp.makeConstraints { make in
            make.left.equalTo(startView)
            make.top.equalTo(startView.snp.bottom).offset(20)
        }
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(5)
            make.centerY.equalTo(icon)
        }
        queryBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(-20)
            make.height.equalTo(45)
        }
    }
    
}
