//
//  ZKImageCollectionCell.swift
//  DNYTY
//
//  Created by WL on 2022/7/4
//  
//
    

import UIKit

class ZKImageCollectionCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
