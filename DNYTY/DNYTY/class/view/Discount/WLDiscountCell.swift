//
//  WLDiscountCell.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit

class WLDiscountCell: UITableViewCell {

    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(hexString: "0E0D20")
        contentView.addSubview(img)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    var imgStr: String? {
        didSet {
            img.sd_setImage(with: URL(string:(imgStr ?? "")), completed: nil)
        }
    }
}
