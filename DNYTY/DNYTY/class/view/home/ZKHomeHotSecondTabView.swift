//
//  ZKHomeHotSecondTabView.swift
//  DNYTY
//
//  Created by WL on 2022/6/9
//  
//
    

import UIKit

class ZKHomeHotSecondTabView: ZKView {

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, ZKHomeServer.Game>>  { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKHomeSecondGameTabCell
        cell.icon.sd_setImage(with: item.imgURL)
        
        return cell
    }
    
    let items: PublishRelay<[SectionModel<String, ZKHomeServer.Game>]> = PublishRelay()
    


    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override func makeUI() {
        backgroundColor = UIColor(hexString: "#0E0D20")
        
        addSubview(collectionView)
        
        
        
        
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        }
        
        collectionView.delegate = self
        collectionView.register(ZKHomeSecondGameTabCell.self, forCellWithReuseIdentifier: "cell")
        
        items.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        items.filter{ $0.count != 0 && $0[0].items.count != 0 }.bind { [weak self] _ in
            self?.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        }.disposed(by: rx.disposeBag)
        
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#25244A")
        addSubview(line)
        line.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension ZKHomeHotSecondTabView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.height - 2
        return CGSize(width: height * 60.0/45, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


class ZKHomeSecondGameTabCell: UICollectionViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundView = UIImageView(image: RImage.home_btnbg())
        selectedBackgroundView = UIImageView(image: RImage.hot_sel2())
        
        
        contentView.addSubview(icon)
        
        
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
