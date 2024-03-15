//
//  ZKCardDepositViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit

class ZKCardDepositViewController: ZKViewController {

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKCardDepositCellViewModel>> { _, tableView, indexPath, viewModel in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKCardDepositInputCell
        
        let isShow = viewModel.isShow.value
        cell.topView.titleLab.text = viewModel.name
        cell.topView.detailLab.text = viewModel.quota
        cell.topView.showBtn.isSelected = isShow
        cell.inView.moneyField.placeholder = viewModel.moneyPlaceholder
        cell.bottomView.isHidden = !isShow
        
        cell.submitBtn.rx.tap.withLatestFrom(cell.inView.rx.money).bind(to: viewModel.submitTap).disposed(by: cell.disposeBag)
        
        
        cell.topView.rx.tap().map{ !cell.topView.showBtn.isSelected }.bind(to: viewModel.isShow).disposed(by: cell.disposeBag)
        
        cell.selectBank.rx.tap().bind { [weak cell] in
            guard let cell = cell, let window = UIApplication.appDeltegate.window else { return }
            
            let point = cell.selectBank.superview!.convert(CGPoint(x: cell.selectBank.left, y: cell.selectBank.bottom), toViewOrWindow: window)
            
            
            let selectView = ZKSelectListView.show(list: viewModel.bankNames, selectIndex: viewModel.selectBankIndex.value) { make in
                make.left.equalTo(point.x)
                make.top.equalTo(point.y)
                make.width.equalTo(cell.selectBank.width)
            }
            
            selectView.tableView.rx.itemSelected.map{ $0.row }.bind(to: viewModel.selectBankIndex).disposed(by: cell.disposeBag)
        }.disposed(by: cell.rx.disposeBag)
        viewModel.selectBankName.bind(to: cell.selectBank.detailLab.rx.text).disposed(by: cell.disposeBag)
        return cell
    }
    
    let hitBtn: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: RImage.pay_hit_btn(), style: .plain, target: nil, action: nil)
        return barButtonItem
    }()
    
    let headerView = ZKDepositHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * amount375(90)))
    
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.register(ZKCardDepositInputCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func initSubView() {
        title = "recharge4".wlLocalized
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.backgroundColor = view.backgroundColor
        
        
        view.addSubview(tableView)
        
        self.navigationItem.rightBarButtonItem = hitBtn
        
        tableView.tableHeaderView = headerView
        headerView.titleBtn.setTitle("recharge16".wlLocalized, for: .normal)
        
    }
    
    override func layoutSubView() {
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
            make.bottom.equalTo(-9)
        }
    }
    
    override func bindViewModel() {
        
        hitBtn.rx.tap.bind{[weak self] in
            self?.navigator.show(segue: .payHelp, sender: self, transition: .modal)
        }.disposed(by: rx.disposeBag)
        
//        let items = [ZKCardDepositCellViewModel(), ZKCardDepositCellViewModel(), ZKCardDepositCellViewModel()]
//
//        var reloadIndexPath: [Observable<IndexPath>] = []
//        for (i, viewModel) in items.enumerated() {
//            reloadIndexPath.append(viewModel.isShow.map{ _ in IndexPath(item: i, section: 0) }.skip(1))
//        }
//
        
        
//        Observable.just([SectionModel(model: "", items: items)]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
//
//        Observable.from(reloadIndexPath).merge().bind{ indexPath in
//            self.tableView.reloadRow(at: indexPath, with: .automatic)
//        }.disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKCardDepositViewModel else { return }
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        let input = ZKCardDepositViewModel.Input()
        let output = viewModel.transform(input: input)
        output.channels.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.reloadIndexPath.drive{[weak self] indexPath in
            guard let self = self else { return  }
            self.tableView.reloadRow(at: indexPath, with: .automatic)
        }.disposed(by: rx.disposeBag)
        output.payResult.drive {[weak self] result in
            guard let self = self else { return  }
            if result.isOK {
                self.navigator.openUrl(url: result.data!)
            } else {
                DefaultWireFrame.showPrompt(text: result.message!)
            }
            
            
        }.disposed(by: rx.disposeBag)
    }
}
