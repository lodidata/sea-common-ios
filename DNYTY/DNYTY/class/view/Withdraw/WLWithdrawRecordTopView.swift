//
//  WLWithdrawRecordTopView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit

class WLWithdrawRecordTopView: UIView {

    
    private lazy var lab1: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw16".wlLocalized
        return lab
    }()
    lazy var startBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
//        btn.setImage(UIImage.init(named: "down_more_gray"), for: .normal)
//        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    private lazy var separate: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = "~"
        return lab
    }()
    lazy var endBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.titleLabel?.font = kSystemFont(12)
//        btn.setImage(UIImage.init(named: "down_more_gray"), for: .normal)
//        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
//    private lazy var lab2: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "72788B")
//        lab.font = kSystemFont(12)
//        lab.text = "总计"
//        return lab
//    }()
//    lazy var numlab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "30333A")
//        lab.font = kSystemFont(12)
//        lab.text = "--"
//        return lab
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(lab1)
        addSubview(startBtn)
        addSubview(separate)
        addSubview(endBtn)
        addSubview(line)
//        addSubview(lab2)
//        addSubview(numlab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab1.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.top.equalTo(15)
        }
        endBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.centerY.equalTo(lab1)
        }
        separate.snp.makeConstraints { make in
            make.right.equalTo(endBtn.snp.left).offset(-3)
            make.centerY.equalTo(lab1)
        }
        startBtn.snp.makeConstraints { make in
            make.right.equalTo(separate.snp.left).offset(-3)
            make.centerY.equalTo(lab1)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
//        lab2.snp.makeConstraints { make in
//            make.left.equalTo(lab1)
//            make.top.equalTo(line.snp.bottom).offset(8)
//        }
//        numlab.snp.makeConstraints { make in
//            make.right.equalTo(endBtn)
//            make.centerY.equalTo(lab2)
//        }
    }
}

class WLRecordDateView: UIView {

    
    private lazy var dateTitle: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "withdraw16".wlLocalized
        return lab
    }()
    lazy var startLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    
    private lazy var separate: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = "~"
        return lab
    }()
    lazy var endLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.text = "--"
        return lab
    }()
    
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
//    lazy var xiazhuTitleLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "72788B")
//        lab.font = kSystemFont(12)
//        lab.text = "下注总计"
//        return lab
//    }()
//    lazy var xiazhuLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "30333A")
//        lab.font = kSystemFont(12)
//        lab.text = "--"
//        return lab
//    }()
//    private lazy var line1: UIView = {
//        let line = UIView()
//        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
//        return line
//    }()
//    lazy var shuyingTitleLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "72788B")
//        lab.font = kSystemFont(12)
//        lab.text = "输赢总计"
//        return lab
//    }()
//    lazy var shuyingLab: UILabel = {
//        let lab = UILabel()
//        lab.textColor = UIColor.init(hexString: "30333A")
//        lab.font = kSystemFont(12)
//        lab.text = "--"
//        return lab
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(dateTitle)
        addSubview(startLab)
        addSubview(separate)
        addSubview(endLab)
        addSubview(line)
//        addSubview(xiazhuTitleLab)
//        addSubview(xiazhuLab)
//        addSubview(line1)
//        addSubview(shuyingTitleLab)
//        addSubview(shuyingLab)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateTitle.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.top.equalTo(8)
        }
        endLab.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.centerY.equalTo(dateTitle)
        }
        separate.snp.makeConstraints { make in
            make.right.equalTo(endLab.snp.left).offset(-3)
            make.centerY.equalTo(dateTitle)
        }
        startLab.snp.makeConstraints { make in
            make.right.equalTo(separate.snp.left).offset(-3)
            make.centerY.equalTo(dateTitle)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(dateTitle.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
//        xiazhuTitleLab.snp.makeConstraints { make in
//            make.left.equalTo(dateTitle)
//            make.top.equalTo(line.snp.bottom).offset(8)
//        }
//        xiazhuLab.snp.makeConstraints { make in
//            make.right.equalTo(endLab)
//            make.centerY.equalTo(xiazhuTitleLab)
//        }
//        line1.snp.makeConstraints { make in
//            make.left.right.height.equalTo(line)
//            make.top.equalTo(xiazhuTitleLab.snp.bottom).offset(8)
//        }
//        shuyingTitleLab.snp.makeConstraints { make in
//            make.left.equalTo(dateTitle)
//            make.top.equalTo(line1.snp.bottom).offset(8)
//        }
//        shuyingLab.snp.makeConstraints { make in
//            make.right.equalTo(endLab)
//            make.centerY.equalTo(shuyingTitleLab)
//        }
    }
}
