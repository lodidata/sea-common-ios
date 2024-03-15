//
//  WLRealDataView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit

class WLRealDataView: UIView {

    var dataList: [WLSpreadRealDataModel] = [WLSpreadRealDataModel(imageName: "self_water_icon", data: "-", title: "agency45".wlLocalized),WLSpreadRealDataModel(imageName: "next_level_water", data: "-", title: "agency46".wlLocalized),WLSpreadRealDataModel(imageName: "total_water", data: "-", title: "agency28".wlLocalized),WLSpreadRealDataModel(imageName: "register_user_icon", data: "-", title: "agency14".wlLocalized),WLSpreadRealDataModel(imageName: "next_level", data: "-", title: "agency16".wlLocalized),WLSpreadRealDataModel(imageName: "total_rechange_icon", data: "-", title: "agency17".wlLocalized),WLSpreadRealDataModel(imageName: "total_rechange_e", data: "-", title: "agency18".wlLocalized),WLSpreadRealDataModel(imageName: "yingkui_icon", data: "-", title: "agency22".wlLocalized)]
    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        return dateFormmater
    }()
    lazy var titleView: WLSpreadTitleView = {
        let aView = WLSpreadTitleView()
        aView.titleLab.text = "agency12".wlLocalized
        aView.dateLab.text = formatter.string(from: Date())
        aView.alertLab.text = "agency13".wlLocalized
        return aView
    }()

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: (kScreenWidth-50)/3, height: 96)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(WLSpreadRealDataCell.classForCoder(), forCellWithReuseIdentifier: "real")
                
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleView)
        addSubview(collectionView)
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
}
extension WLRealDataView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "real", for: indexPath) as! WLSpreadRealDataCell
        if indexPath.item < dataList.count {
            cell.dataModel = dataList[indexPath.item]
        }
        return cell
    }
    
    
    
}

class WLSpreadTitleView: UIView {
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(16)
        return lab
    }()
    lazy var dateLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        return lab
    }()
    lazy var alertLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "969CB0")
        lab.font = kSystemFont(12)
        lab.numberOfLines = 0
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLab)
        addSubview(dateLab)
        addSubview(alertLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
        }
        dateLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab.snp.right).offset(5)
            make.centerY.equalTo(titleLab)
        }
        alertLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.right.equalTo(-15)
            make.top.equalTo(titleLab.snp.bottom).offset(5)
        }
    }
    
}

class WLSpreadRealDataCell: UICollectionViewCell {
    
    lazy var item: WLSpreadRealDataItem = {
        let item = WLSpreadRealDataItem()
        return item
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        item.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var dataModel: WLSpreadRealDataModel? {
        didSet {
            item.img.image = UIImage.init(named: dataModel?.imageName ?? "")
            item.dataLab.text = dataModel?.data
            item.titleLab.text = dataModel?.title
        }
    }
}
class WLSpreadRealDataItem: UIView {
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        return img
    }()
    lazy var dataLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kMediumFont(16)
        return lab
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.textAlignment = .center
        lab.numberOfLines = 0
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.masksToBounds = true
        addSubview(img)
        addSubview(dataLab)
        addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
        }
        dataLab.snp.makeConstraints { make in
            make.top.equalTo(img.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(dataLab.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
