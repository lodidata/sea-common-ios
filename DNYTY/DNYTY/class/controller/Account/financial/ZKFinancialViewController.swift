//
//  ZKFinancialViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/23
//  
//
    

import UIKit

class ZKFinancialViewController: ZKViewController {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKFinancialCell
        cell.titleLab.text = item
        return cell
    }
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.rowHeight = 70
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.separatorStyle = .none
        tableView.register(ZKFinancialCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let headerView = ZKFinancialHeaderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 295))

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "account13".wlLocalized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func initSubView() {
        view.addSubview(tableView)
        //tableView.tableHeaderView = headerView
    }
    
    override func layoutSubView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        
        
        tableView.rx.itemSelected.bind { [weak self] indexPath in
            guard let self = self else {
                return
            }
            
            switch indexPath.item {
            case 0:
                self.navigator.show(segue: .accountDetail, sender: self)
            case 1:
                self.navigator.show(segue: .depositRecord2, sender: self)
            case 2:
                self.navigator.show(segue: .applys, sender: self)
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
       
        
        Observable.just([SectionModel(model: "", items: ["finance4".wlLocalized, "recharge1".wlLocalized, "finance5".wlLocalized])]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKFinancialViewModel else { return  }
        let input = ZKFinancialViewModel.Input(searchTap: headerView.searchBtn.rx.tap.asObservable(),
                                               startDateTap: headerView.startBtn.rx.tap(),
                                               endDateTap: headerView.endBtn.rx.tap()
        )
        let output = viewModel.transform(input: input)
        output.depositTotal.drive(headerView.depositTotalView.totalLab.rx.text).disposed(by: rx.disposeBag)
        output.withdrawTotal.drive(headerView.withdeawTotalView.totalLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.startTime.bind(to: headerView.startBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.endTime.bind(to: headerView.endBtn.textLab.rx.text).disposed(by: rx.disposeBag)
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
