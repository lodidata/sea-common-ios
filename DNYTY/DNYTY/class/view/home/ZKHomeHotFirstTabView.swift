//
//  ZKHomeHotGameTabView.swift
//  DNYTY
//
//  Created by WL on 2022/6/9
//  
//
    

import UIKit

class ZKHomeHotFirstTabView: ZKView {

    
    


    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override func makeUI() {
        backgroundColor = RGB(22, 23, 44)
        
        addSubview(collectionView)
        
        
        
        
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.register(ZKHomeFirstGameTabCell.self, forCellWithReuseIdentifier: "cell")
        

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension ZKHomeHotFirstTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.height - 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


class ZKHomeFirstGameTabCell: UICollectionViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lab.font = kMediumFont(12)
        lab.adjustsFontSizeToFitWidth = true
        lab.text = "   "
        return lab
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundView = UIImageView(image: RImage.home_btnbg())
        selectedBackgroundView = UIImageView(image: RImage.home_hot_sel())
        
        
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
