//
//  WLAccountCell.swift
//  DNYTY
//
//  Created by wulin on 2022/6/20.
//

import UIKit

class WLAccountCell: UITableViewCell {

    
    private lazy var icon: UIImageView = {
        let icon = UIImageView.init()
        icon.contentMode = .center
        return icon
    }()
    private lazy var lab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = .white
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor.init(hexString: "39375A")
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(lab)
        contentView.addSubview(line)
        contentView.backgroundColor = RGB(22, 23, 44)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        lab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    var data: WLAccountDataStruct? {
        didSet {
            icon.image = UIImage.init(named: data!.imgName)
            lab.text = data!.title
        }
    }
    
}
