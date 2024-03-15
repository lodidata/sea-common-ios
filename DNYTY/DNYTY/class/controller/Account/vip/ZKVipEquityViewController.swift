//
//  ZKVipEquityViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/27
//  
//
    

import UIKit
import SDCycleScrollView
import FSPagerView

class ZKVipEquityViewController: ZKScrollViewController {
    
    let bannerView: FSPagerView = {
       let bannerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * amount375(155)))
        bannerView.automaticSlidingInterval = 3
        bannerView.backgroundColor = .black
        bannerView.isInfinite = true
        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerCell")
        return bannerView
    }()
    
    let levelView: FSPagerView = {
       let bannerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * amount375(155)))
        bannerView.transformer = FSPagerViewTransformer(type: .overlap)
        bannerView.interitemSpacing = 10
        bannerView.itemSize = CGSize(width: kScreenWidth - 100, height: (kScreenWidth - 100) * 140.0/300)
        bannerView.register(ZKVipCollectionCell.self, forCellWithReuseIdentifier: "bannerCell")
        return bannerView
    }()
    
    var pagerControl: FSPageControl = {
           let pageControl = FSPageControl()
           pageControl.contentHorizontalAlignment = .center
           //设置下标指示器颜色（选中状态和普通状态）
           pageControl.setFillColor(UIColor(hexString: "#D0D4E0"), for: .normal)
           pageControl.setFillColor(UIColor(hexString: "#7F4FE8"), for: .selected)
           //绘制下标指示器的形状 (roundedRect绘制绘制圆角或者圆形)
   //        pageControl.setPath(UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 8, width: 8, height: 5),cornerRadius: 4.0), for: .normal)
           
           pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .normal)
           pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .selected)
           return pageControl

       }()
    let equityView: ZKVipEquityView = {
       let view = ZKVipEquityView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.register(ZKVipEquityTableCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 34
        return tableView
    }()
    
    let equityHeaderView: ZKVipEquityTableHeader = {
       let view = ZKVipEquityTableHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "vip12".wlLocalized
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func initSubView() {
        super.initSubView()
        
        contentView.addSubview(bannerView)
        contentView.addSubview(levelView)
        contentView.addSubview(pagerControl)
        contentView.addSubview(equityView)
        contentView.addSubview(tableView)
        tableView.tableHeaderView = equityHeaderView
        
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
           
        }
        
        bannerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(bannerView.snp.width).multipliedBy(amount375(155))
        }
        
        levelView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom)
            make.height.equalTo(bannerView.snp.width).multipliedBy(amount375(180))
        }
        
        pagerControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalTo(levelView.snp.bottom)
        }
        equityView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(pagerControl.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(equityView.snp.bottom).offset(25)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
            make.bottom.equalTo(-50)
        }
        
        tableView.rx.observe(CGSize.self, "contentSize").bind { [weak self] contentSize in
            guard let self = self, let contentSize = contentSize else { return  }
            self.tableView.snp.remakeConstraints { make in
                make.top.equalTo(self.equityView.snp.bottom).offset(25)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(contentSize.height)
                make.bottom.equalTo(-50)
            }
        }.disposed(by: rx.disposeBag)
        
        
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        guard let viewModel = viewModel as? ZKVipEquityViewModel else { return  }
        //UICollectionView().rx.items(cellIdentifier: <#T##String#>)
        
        let input = ZKVipEquityViewModel.Input(viewWillShow: rx.viewDidAppear.mapToVoid())
        let output = viewModel.transform(input: input)
        
        output.currentLevel.drive(equityView.rx.level).disposed(by: rx.disposeBag)
        
        output.bannerImageUrls.drive(bannerView.rx.items(cellIdentifier: "bannerCell")){ _, item, cell in
            cell.imageView?.sd_setImage(with: item, completed: nil)
        }.disposed(by: rx.disposeBag)

  
        output.levels.drive(levelView.rx.items(cellIdentifier: "bannerCell", cellType: ZKVipCollectionCell.self)){ _, item, cell in
            cell.icon.sd_setImage(with: URL(string: item.icon ), completed: nil)
            cell.moneyLab.text = "vip26".wlLocalized + " >= " + (item.depositMoney/100).stringValue
        }.disposed(by: rx.disposeBag)
        

        output.levels.map{ $0.count }.drive(pagerControl.rx.numberOfPages).disposed(by: rx.disposeBag)
        levelView.rx.itemScrolled.bind(to: pagerControl.rx.currentPage).disposed(by: rx.disposeBag)
       
        
        output.levels.drive(tableView.rx.items(cellIdentifier: "cell", cellType: ZKVipEquityTableCell.self)) { _, item, cell in
            cell.levelLab.text = item.name
            cell.depositLab.text = (item.depositMoney/100).stringValue
            cell.loerttyLab.text = (item.lotteryMoney/100).stringValue
            cell.monthlyMoneyLab.text = (item.monthlyMoney/100).stringValue
            cell.promoteHandselLab.text = (item.promoteHandsel/100).stringValue
        }.disposed(by: rx.disposeBag)
        
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        
        
        
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
