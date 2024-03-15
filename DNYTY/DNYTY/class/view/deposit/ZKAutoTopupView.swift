//
//  ZKAutoTopupView.swift
//  DNYTY
//
//  Created by WL on 2022/7/1
//  
//
    

import UIKit

class ZKAutoTopupView: ZKView {
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        let attrStr = NSAttributedString(string: "recharge47".wlLocalized, attributes: [.foregroundColor: UIColor(hexString: "#72788B") ?? .gray, .font: kMediumFont(14), .underlineStyle: NSUnderlineStyle.single])
        lab.attributedText = attrStr
        return lab
    }()
    
    let textLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = UIColor(hexString: "#FF354A")
        lab.font = kSystemFont(12)
        lab.text = "*" + "recharge48".wlLocalized
        return lab
    }()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, String>>  { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKAutoTopupCell
        
        return cell
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(ZKAutoTopupCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor(hexString: "#EDEEF3")
        collectionView.layer.cornerRadius = 2
        collectionView.layer.masksToBounds = true
        
        return collectionView
    }()
    
    let copyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 311, height: 44))
        bg.cornerRadius = 4
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("agency43".wlLocalized, for: .normal)
        
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(14)
        return btn
    }()
    
    override func makeUI() {
        backgroundColor = .white
        layer.cornerRadius = 5
        
        
        addSubview(titleLab)
        addSubview(textLab)
        addSubview(collectionView)
        addSubview(copyBtn)
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(16)
            make.right.lessThanOrEqualTo(-16)
            make.top.equalTo(25)
        }
        
        textLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(16)
            make.right.lessThanOrEqualTo(-16)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(textLab.snp.bottom).offset(22)
            make.height.equalTo(collectionView.snp.width).multipliedBy(68.0/311)
        }
        
        
        copyBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(collectionView.snp.bottom).offset(25)
            make.bottom.equalTo(-25)
        }
        
        collectionView.delegate = self
        
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ZKAutoTopupView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.size
    }
}

class ZKAutoTopupCell: UICollectionViewCell {
    
    
    let bankTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "Bank:"
        //lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let nameTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "Account Name:"
        lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let accountTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "Account:"
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        //lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let bankLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "AUB"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    let nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "novo hermosilla flores"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    let accountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "09063364388"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 2
        backgroundColor = UIColor(hexString: "#EDEEF3")
        
        contentView.addSubview(bankTitleLab)
        contentView.addSubview(nameTitleLab)
        contentView.addSubview(accountTitleLab)
        
        contentView.addSubview(bankLab)
        contentView.addSubview(nameLab)
        contentView.addSubview(accountLab)
        
        bankTitleLab.snp.makeConstraints { make in
            make.left.equalTo(13)
            make.top.equalTo(8)
            
        }
        nameTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(bankTitleLab.snp.bottom).offset(5)
        }
        
        accountTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(nameTitleLab.snp.bottom).offset(5)
            make.bottom.equalTo(-8)
        }
        
        bankLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(bankTitleLab)
            make.right.equalTo(-20)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(nameTitleLab)
            make.right.equalTo(-20)
        }
        
        accountLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(accountTitleLab)
            make.right.equalTo(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
