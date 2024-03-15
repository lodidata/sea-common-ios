//
//  ZKGcashDepositViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKGcashDepositViewController: ZKViewController {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKGcashDepositCellViewModel>> { _, tableView, indexPath, viewModel in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKGcashDepositInputCell
        
        let isShow = viewModel.isShow.value
        cell.topView.titleLab.text = viewModel.name
        cell.topView.detailLab.text = viewModel.quota
        cell.topView.showBtn.isSelected = isShow
        cell.inView.moneyField.placeholder = viewModel.moneyPlaceholder
        cell.bottomView.isHidden = !isShow
        
        cell.inView.rowCount = Int(ceil(Double(viewModel.moneyList.count)/4.0))
        cell.inView.numbers.accept(viewModel.moneyList)
        
        cell.submitBtn.rx.tap.withLatestFrom(cell.inView.rx.money).map {
            (viewModel.channel, $0)
        }.bind(to: viewModel.submitTap).disposed(by: cell.disposeBag)
        
        
        cell.topView.rx.tap().map{ !cell.topView.showBtn.isSelected }.bind(to: viewModel.isShow).disposed(by: cell.disposeBag)
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
        tableView.register(ZKGcashDepositInputCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func initSubView() {
        title = "GCASH"
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.backgroundColor = view.backgroundColor
        
        
        view.addSubview(tableView)
        
        self.navigationItem.rightBarButtonItem = hitBtn
        
        tableView.tableHeaderView = headerView
        
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
        
//        let items = [ZKGcashDepositCellViewModel(), ZKGcashDepositCellViewModel(), ZKGcashDepositCellViewModel()]
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
        
        guard let viewModel = viewModel as? ZKGcashDepositViewModel else { return }
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        let input = ZKGcashDepositViewModel.Input()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
