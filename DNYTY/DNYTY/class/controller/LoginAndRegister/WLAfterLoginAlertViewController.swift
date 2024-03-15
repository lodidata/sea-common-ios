//
//  WLAfterLoginAlertView.swift
//  NEW
//
//  Created by wulin on 2022/4/6.
//

import UIKit

class WLAfterLoginAlertViewController: ZKViewController {

    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kMediumFont(16)
        lab.text = "account6".wlLocalized
        return lab
    }()

    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, WLNoticeAppDataModel>>  { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginAlert", for: indexPath) as! WLAfterLoginAlertCell
        cell.dataModel = item
        return cell
    }
    private lazy var bgView: UIView = {
        let aView = UIView.init()
        aView.backgroundColor = UIColor(hexString: "#111845")
        aView.layer.cornerRadius = 10
        aView.layer.masksToBounds = true
        return aView
    }()
    
    
    private lazy var removeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.noti_close1(), for: .normal)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        btn.tag = 1
        return btn
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bgl = kSubmitButtonLayer1(size: CGSize(width: 308, height: 44))
        bgl.cornerRadius = 5
        btn.setBackgroundImage(bgl.snapshotImage(), for: .normal)
        btn.setTitle("text1".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(16)
        
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: kScreenWidth-30, height: 282)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WLAfterLoginAlertCell.classForCoder(), forCellWithReuseIdentifier: "loginAlert")
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl.init()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = RGB(100, 66, 165)
        //pageControl.numberOfPages = 2
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hero.isEnabled = true
        bgView.hero.modifiers = [.translate( y: -200), .fade]
    }
    
    override func initSubView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(bgView)
        
        bgView.addSubview(titleLab)
        bgView.addSubview(removeBtn)
        bgView.addSubview(collectionView)
        bgView.addSubview(pageControl)
        //bgView.addSubview(closeBtn)
    }
    

    override func layoutSubView() {
        bgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(bgView.snp.width)
        }
        
        titleLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(19)
        }
        
        removeBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleLab.snp.centerY)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor(white: 1, alpha: 0.2)
        bgView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(titleLab.snp.bottom).offset(19)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(22)
            make.left.equalTo(33)
            make.right.equalTo(-33)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.equalTo(-30)
        }
        
    }
    
    override func bindViewModel() {
       
        
        guard let viewModel = viewModel as? WLAfterLoginAlertViewModel else { return }
        viewModel.listOutput.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        pageControl.numberOfPages = viewModel.items.count
    }
    

    @objc func btnClick(btn: UIButton) {
        self.navigator.dismiss(sender: self)
    }

}

extension WLAfterLoginAlertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.width, height: collectionView.height)
    }
    
    
}
extension WLAfterLoginAlertViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        print(xOffset)
        let page: Int = (Int)(xOffset / (scrollView.width))
        pageControl.currentPage = page
    }
}


class WLAfterLoginAlertViewModel: ZKViewModel {
    let items: [WLNoticeAppDataModel]
    
    let listOutput: Driver<[SectionModel<String, WLNoticeAppDataModel>]>
    init(items: [WLNoticeAppDataModel]) {
        self.items = items
        
        listOutput = Observable.just([SectionModel(model: "", items: items)]).asDriver(onErrorJustReturn: [])
    }
}
