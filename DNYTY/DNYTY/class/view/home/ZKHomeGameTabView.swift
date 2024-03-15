//
//  ZKHomeGameTabView.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit
import RxRelay

class ZKHomeGameTabView: ZKView {

    
    let background: UIImageView = {
        let imgV = UIImageView(image:RImage.home_bg1())
//        imgV.contentMode = <#contentMode#>
        return imgV
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override func makeUI() {
        addSubview(background)
        
        addSubview(collectionView)
        
        
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 12, bottom: 12, right: 12))
//            make.left.equalTo(17)
//            make.right.equalTo(-17)
//            make.bottom.equalTo(-12)
//            make.top.equalTo(20)
        }
        
        collectionView.delegate = self
        collectionView.register(ZKHomeGameTabCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ZKHomeGameTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.height - 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        14
    }
}



class ZKHomeGameTabCell: UICollectionViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#B4B4B4")
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lab.font = kMediumFont(12)
        lab.text = "   "
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = UIImageView(image: RImage.home_btnbg())
        selectedBackgroundView = UIImageView(image: RImage.home_btnbg_select1())
        
        
        contentView.addSubview(icon)
        contentView.addSubview(titleLab)
        
        titleLab.snp.makeConstraints { make in
            make.bottom.equalTo(-7)
            make.left.greaterThanOrEqualTo(5)
            make.right.lessThanOrEqualTo(-5)
            make.centerX.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(titleLab.snp.top).offset(-1)
            make.centerX.equalToSuperview()
        }
        
    }
    
    override var isSelected: Bool {
        didSet {
            titleLab.textColor = isSelected ? .white : UIColor(hexString: "#B4B4B4")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
