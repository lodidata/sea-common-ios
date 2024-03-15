//
//  WLAllWalletController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLAllWalletController: ZKViewController {

    private var dataList: [WLThirdWalletChildModel]? = []
    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = "account9".wlLocalized
        return aView
    }()
    private lazy var topView: WLWalletTopView = {
        let aView = WLWalletTopView()
        return aView
    }()
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: (kScreenWidth-50)/3, height: 65)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.register(WLWalletCollectViewCell.classForCoder(), forCellWithReuseIdentifier: "wallet")
                
        return collectionView
    }()
    private lazy var alertView: WLWallertRecycleAlertView = {
        let aView = WLWallertRecycleAlertView()
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        getWallet()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(navView)
        view.addSubview(topView)
        view.addSubview(collectionView)
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(150)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        //刷新按钮
        topView.refreshBtn.rx.tap
            .bind { [unowned self] _ in
                getWallet()
            }.disposed(by: rx.disposeBag)
        //一键转回
        topView.btn.rx.tap
            .bind { [unowned self] _ in
                view.addSubview(alertView)
                alertView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        
        //弹窗取消按钮
        alertView.cancelBtn.rx.tap
            .bind { [unowned self] _ in
                alertView.removeFromSuperview()
            }.disposed(by: rx.disposeBag)
        //弹窗继续按钮
        alertView.goOnBtn.rx.tap
            .bind { [unowned self] _ in
                alertView.removeFromSuperview()
                getWalletRefresh()
            }.disposed(by: rx.disposeBag)
    }

}
extension WLAllWalletController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wallet", for: indexPath) as! WLWalletCollectViewCell
        if indexPath.item < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.item]
        }
        return cell
    }
    
    
    
}

extension WLAllWalletController {
    //ZKWalletServer.Wallet
    func getWallet() {
        WLProvider.request(.thirdList(refresh: 0)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel = WLWallet.init(JSON: json["data"].dictionaryObject ?? [:]) {
                            self.topView.amountLab.text = dataModel.sumBalance.divide100().stringValue
                            self.dataList = dataModel.child
                            self.collectionView.reloadData()
                        }
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func getWalletRefresh() {
        WLProvider.request(.thirdRefresh) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.getWallet()
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
