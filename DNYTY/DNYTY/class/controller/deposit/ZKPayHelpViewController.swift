//
//  ZKPayHelpViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/16
//  
//
    

import UIKit

class ZKPayHelpViewController: ZKViewController {
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(20)
        lab.text = "recharge36".wlLocalized
        return lab
    }()
    
    let subTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kSystemFont(14)
        lab.text = "recharge36".wlLocalized
        return lab
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(RImage.close_btn1(), for: .normal)
        
        return btn
    }()
    
    let textView: UITextView = {
       let textView = UITextView()
        textView.font = kSystemFont(14)
        textView.textColor = UIColor(hexString: "#72788B")
        textView.text = "recharge37".wlLocalized + "recharge38".wlLocalized + "recharge39".wlLocalized + "recharge40".wlLocalized + "recharge41".wlLocalized
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        hero.isEnabled = true
        contentView.hero.modifiers = [.translate( y: -200), .fade]
    }
    

    override func initSubView() {
        view.addSubview(contentView)
        contentView.addSubview(closeBtn)
        contentView.addSubview(titleLab)
        contentView.addSubview(subTitleLab)
        contentView.addSubview(textView)
    }
    
    override func layoutSubView() {
        contentView.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.greaterThanOrEqualTo(30).priority(.high)
            make.bottom.lessThanOrEqualTo(-30).priority(.high)
            make.centerY.equalToSuperview().offset(-20).priority(.low)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(17)
            make.right.equalTo(-17)
        }
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(closeBtn.snp.bottom).offset(6)
        }
        
        subTitleLab.snp.makeConstraints { make in
            make.left.equalTo(34)
            make.top.equalTo(titleLab.snp.bottom).offset(26)
        }
        
        textView.rx.observe(CGSize.self, "contentSize").bind {[weak self] contentSize in
            guard let self = self, let contentSize = contentSize else { return  }
            self.textView.snp.remakeConstraints { make in
                make.left.equalTo(self.subTitleLab)
                make.top.equalTo(self.subTitleLab.snp.bottom).offset(14)
                make.right.equalTo(-13)
                make.bottom.equalTo(-60)
                make.height.equalTo(contentSize.height)
            }
        }.disposed(by: rx.disposeBag)
    }
    
    override func bindViewModel() {
        closeBtn.rx.tap.bind { [weak self] in
            self?.navigator.dismiss(sender: self)
        }.disposed(by: rx.disposeBag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
