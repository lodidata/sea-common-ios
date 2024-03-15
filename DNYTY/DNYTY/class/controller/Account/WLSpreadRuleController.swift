//
//  WLSpreadRuleController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/29.
//

import UIKit

class WLSpreadRuleController: ZKViewController {

    private lazy var bgImg: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleToFill
        img.image = RImage.head_spread_bg()
        return img
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(16)
        lab.text = "agency1".wlLocalized
        return lab
    }()
    lazy var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.guanbi_bai(), for: .normal)
        return btn
    }()
    private lazy var scrollView: UIScrollView = {
        let aView = UIScrollView()
        return aView
    }()
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = UIImage.init(named: "explain1")
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
    }
    
    
    override func initSubView() {
        view.addSubview(bgImg)
        view.addSubview(titleLab)
        view.addSubview(closeBtn)
        view.addSubview(scrollView)
        scrollView.addSubview(img)

    }
    
    override func layoutSubView() {
        super.layoutSubView()
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(270)
        }
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(NAV_STATUS_HEIGHT+10)
        }
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(titleLab)
        }
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
        img.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenWidth * 6098 / 750)
        }

    }

    override func bindViewModel() {
        super.bindViewModel()
        closeBtn.rx.tap.bind { [unowned self] _ in
            navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
    }
}
