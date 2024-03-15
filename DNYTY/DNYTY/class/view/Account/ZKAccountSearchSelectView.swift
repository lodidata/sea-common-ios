//
//  ZKAccountSearchSelectView.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKAccountSearchSelectView: ZKView {
    
    let typeView: ZKAccountSearchTypeView = {
       let view = ZKAccountSearchTypeView()
        view.textField.isUserInteractionEnabled = false
        return view
    }()

    let startBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        let date = NSDate()

        btn.titleLab.text = "account17".wlLocalized
        btn.textLab.text = date.string(withFormat: "yyyy-MM/-d")

        return btn
    }()
    
    let endBtn: ZKDateSelectButton = {
       let btn = ZKDateSelectButton()
        btn.titleLab.text = "account18".wlLocalized
        let date = NSDate()
        btn.textLab.text = date.string(withFormat: "yyyy-MM-dd")
        return btn
    }()

    let hitIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.deposit_hit2())
        return imgV
    }()
    
    let hitLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "finance10".wlLocalized
        return lab
    }()
    
    let searchBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 343, height: 44))
        bg.cornerRadius = 5
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("finance6".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        return btn
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func makeUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        contentView.addSubview(typeView)
        contentView.addSubview(startBtn)
        contentView.addSubview(endBtn)
        contentView.addSubview(hitIcon)
        contentView.addSubview(hitLab)
        contentView.addSubview(searchBtn)
        
        typeView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(10)
            make.height.equalTo(54)
        }
        
        startBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(typeView.snp.bottom).offset(10)
            make.height.equalTo(54)
        }
        
        endBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn.snp.right).offset(10)
            make.top.equalTo(startBtn)
            make.right.equalTo(-16)
            make.size.equalTo(startBtn)
        }
        
        hitIcon.snp.makeConstraints { make in
            make.left.equalTo(startBtn.snp.left)
            make.top.equalTo(startBtn.snp.bottom).offset(10)
        }
        hitLab.snp.makeConstraints { make in
            make.left.equalTo(hitIcon.snp.right).offset(5)
            make.centerY.equalTo(hitIcon)
        }
        
        searchBtn.snp.makeConstraints { make in
            make.left.equalTo(startBtn)
            make.right.equalTo(endBtn)
            make.top.equalTo(hitLab.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        searchBtn.rx.tap.map{ true }.bind(to: self.rx.isHidden).disposed(by: rx.disposeBag)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


class ZKAccountSearchTypeView: ZKView {
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "finance7".wlLocalized
        return lab
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(hexString: "#30333A")
        textField.font = kMediumFont(14)
        textField.text = "type2Txt1".wlLocalized
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let mordIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.h_ljt())
        imgV.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imgV.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return imgV
    }()
    
    override func makeUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#D6D9E3")?.cgColor
        
        addSubview(titleLab)
        addSubview(textField)
        addSubview(mordIcon)
        
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(9)
            make.left.equalTo(16)
        }
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(2)
            make.bottom.equalTo(-9)
        }
        
        mordIcon.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(5)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
    }
}
