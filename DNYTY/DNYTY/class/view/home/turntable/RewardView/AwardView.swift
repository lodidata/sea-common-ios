//
//  AwardView.swift
//  RewardViewDemo
//
//  Created by cuixuerui on 2019/4/9.
//  Copyright © 2019 cuixuerui. All rights reserved.
//

import UIKit

class AwardView: UIView {
    
//    private let textArcView = CXRTextArcView()
    private lazy var icon: UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFit
        return img
    }()
    private let imageView = UIImageView()
//    private var baseAngle: CGFloat = 0
//    private var radius: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupLayout()
    }
    
    private func setup() {
//        addSubview(textArcView)
        addSubview(icon)
        addSubview(imageView)
    }
    
    private func setupLayout() {
//        textArcView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        icon.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }
    
//    func set(baseAngle: CGFloat, radius: CGFloat) {
//        // 设置圆弧 Label
//        textArcView.textAttributes = [.foregroundColor: UIColor.white,
//                                      .font: RFont.promptMedium(size: 12)]
//        textArcView.characterSpacing = 0.85
//        textArcView.baseAngle = baseAngle
//        textArcView.radius = radius
//    }
    
    func set(title: String, image: String) {
//        textArcView.text = title
//        imageView.image = UIImage(imageLiteralResourceName: image)
        icon.image = UIImage.init(named: "diamond")
        imageView.sd_setImage(with: URL.init(string: image), completed: nil)
    }

}
