//
//  WLWalletCollectViewCell.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLWalletCollectViewCell: UICollectionViewCell {
    private lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "E8E9F0")
        return line
    }()
    private lazy var numberLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        return lab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLab)
        contentView.addSubview(line)
        contentView.addSubview(numberLab)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
        numberLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
    }
    
    var dataModel: WLThirdWalletChildModel? {
        didSet {
            nameLab.text = dataModel?.game_type
            numberLab.text = dataModel?.balance.divide100().stringValue
        }
    }
}
