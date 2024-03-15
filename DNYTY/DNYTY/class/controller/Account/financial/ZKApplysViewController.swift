//
//  ZKApplyViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKApplysViewController: ZKViewController {

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKWalletServer.ApplyModel>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKApplysTableCell

        cell.timelab.text = item.time
        cell.moneyLab.text = (item.money/100).stringValue
        cell.titleLab.text = item.name
        cell.moneyTitleLab.text = "finance16".wlLocalized
       
        return cell
    }
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.register(ZKApplysTableCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.backgroundView = ZKNullDataView()
        tableView.backgroundView?.isHidden = true
        return tableView
    }()
    
//    let headerView = ZKDepositRecordHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
//
    let searchBtn = UIBarButtonItem(image: RImage.deposit_search1(), style: .plain, target: nil, action: nil)

    let selectView: ZKApplysSearchSelectView = {
       let view = ZKApplysSearchSelectView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "finance5".wlLocalized
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        navigationItem.rightBarButtonItem = searchBtn
        
    }
    
    
    override func initSubView() {
        view.addSubview(tableView)
        view.addSubview(selectView)
        //tableView.tableHeaderView = headerView
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
    }
    
    override func layoutSubView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    override func bindViewModel() {
        searchBtn.rx.tap.map{ !self.selectView.isHidden }.bind(to: selectView.rx.isHidden).disposed(by: rx.disposeBag)
        
        
        guard let viewModel = viewModel as? ZKApplysViewModel else { return }
        
        let input = ZKApplysViewModel.Input(headerRefresh: tableView.mj_header!.rx.refreshing.asObservable(),
                                            loadMore: tableView.mj_footer!.rx.refreshing.asObservable(),
                                            startDateTap: selectView.startBtn.rx.tap(),
                                            endDateTap: selectView.endBtn.rx.tap(),
                                            searchTap: selectView.searchBtn.rx.tap.asObservable()
        )
            
        let output = viewModel.transform(input: input)
        output.recordList.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
//        output.time.drive(headerView.timelab.rx.text).disposed(by: rx.disposeBag)
//        output.selectType.drive(selectView.typeView.textField.rx.text).disposed(by: rx.disposeBag)
        output.hasData.drive(tableView.backgroundView!.rx.isHidden).disposed(by: rx.disposeBag)
        
        viewModel.headerLoading.asObservable().bind(to: tableView.mj_header!.rx.endRefreshing).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: tableView.mj_footer!.rx.endRefreshing).disposed(by: rx.disposeBag)
        
        viewModel.startTime.bind(to: selectView.startBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.endTime.bind(to: selectView.endBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        
//        selectView.typeView.rx.tap().bind { [weak self]  in
//            guard let self = self else { return  }
//            let view = self.selectView.typeView
//            let selectView = ZKSelectListView.show(to: view, position: .bottom, width: view.width)
//            viewModel.typeList.map{ $0.map{ $0.title } }.bind(to: selectView.items).disposed(by: selectView.rx.disposeBag)
//            selectView.tableView.rx.itemSelected.map{ $0.row }.map{ viewModel.typeList.value[$0] }.bind(to: viewModel.selectType).disposed(by: selectView.rx.disposeBag)
//        }.disposed(by: rx.disposeBag)
        
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
