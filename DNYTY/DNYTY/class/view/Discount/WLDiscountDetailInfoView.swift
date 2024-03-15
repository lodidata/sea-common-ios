//
//  WLDiscountDetailInfoView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit

class WLDiscountDetailInfoView: UIView {

    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "D4D4D4")
        lab.font = kSystemFont(18)
        return lab
    }()
    private lazy var lineh1: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "39375A")
        return line
    }()
    private lazy var lab1: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "969CB0")
        lab.font = kSystemFont(12)
        lab.text = "discount3".wlLocalized
        return lab
    }()
    private lazy var lineV1: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "39375A")
        return line
    }()
    lazy var lab2: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "E94951")
        lab.font = kSystemFont(12)
        return lab
    }()
    private lazy var lineh2: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "39375A")
        return line
    }()
    lazy var actBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
//        btn.setImage(UIImage.init(named: "kefu_icon"), for: .normal)
//        btn.setTitle("联系客服", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        return btn
    }()
//    private lazy var lineV2: UIView = {
//        let line = UIView()
//        line.backgroundColor = UIColor.init(hexString: "39375A")
//        return line
//    }()
//    lazy var isApply: UIButton = {
//        let btn = UIButton.init(type: .custom)
//        btn.setImage(UIImage.init(named: "discount_noness_icon"), for: .normal)
//        btn.setTitle("", for: .normal)
//        btn.setTitleColor(UIColor.init(hexString: "5FB17E"), for: .normal)
//        btn.titleLabel?.font = kSystemFont(14)
//        return btn
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "171633")
        addSubview(titleLab)
        addSubview(lineh1)
        addSubview(lab1)
        addSubview(lineV1)
        addSubview(lab2)
        addSubview(lineh2)
        addSubview(actBtn)
//        addSubview(lineV2)
//        addSubview(isApply)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.right.equalTo(-15)
            make.height.equalTo(50)
        }
        lineh1.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom)
            make.height.equalTo(1)
        }
        lab1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(lineh1.snp.bottom).offset(13)
        }
        lineV1.snp.makeConstraints { make in
            make.left.equalTo(lab1.snp.right).offset(15)
            make.centerY.equalTo(lab1)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        lab2.snp.makeConstraints { make in
            make.left.equalTo(lineV1.snp.right).offset(15)
            make.centerY.equalTo(lab1)
        }
        lineh2.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(lineh1.snp.bottom).offset(42)
            make.height.equalTo(1)
        }
//        lineV2.snp.makeConstraints { make in
//            make.top.equalTo(lineh2.snp.bottom)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(1)
//            make.centerX.equalToSuperview()
//        }
        actBtn.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(lineh2.snp.bottom)
            make.right.equalToSuperview()
        }
//        isApply.snp.makeConstraints { make in
//            make.right.bottom.equalToSuperview()
//            make.top.equalTo(contractKefu)
//            make.left.equalTo(lineV2.snp.right)
//        }
        
    }
}

//class WLDiscountDetail2InfoView: UIView {
//    lazy var titleLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "D4D4D4")
//        lab.font = kSystemFont(18)
//        lab.numberOfLines = 0
//        return lab
//    }()
//    
//}
