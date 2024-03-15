//
//  ZKDepositRecordViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/20
//  
//
    

import UIKit
import MJRefresh

class ZKDepositRecordViewController: ZKViewController {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKWalletServer.DepositModel>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKDepositRecordCell

        cell.timelab.text = item.time
        cell.moneyLab.text = (item.money/100).stringValue
        cell.numberLab.text = "recharge12".wlLocalized + "  " + item.tradeNo
        cell.copyBtn.rx.tap.bind {
            UIPasteboard.general.string = item.tradeNo
            DefaultWireFrame.showPrompt(text: "new8".wlLocalized)
        }.disposed(by: cell.disposeBag)
        return cell
    }
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.register(ZKDepositRecordCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.backgroundView = ZKNullDataView()
        tableView.backgroundView?.isHidden = true
        return tableView
    }()
    
    let headerView = ZKDepositRecordHeader(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
    
    let searchBtn = UIBarButtonItem(image: RImage.deposit_search1(), style: .plain, target: nil, action: nil)
    
    let dateView: ZKDepositRecordDateView = {
       let view = ZKDepositRecordDateView()

        //view.isHidden = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "recharge1".wlLocalized
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        navigationItem.rightBarButtonItem = searchBtn
    }
    
    override func initSubView() {
        view.addSubview(tableView)
        view.addSubview(dateView)
        tableView.tableHeaderView = headerView
        tableView.mj_header = MJRefreshNormalHeader()
        tableView.mj_footer = MJRefreshBackNormalFooter()
    }

    override func layoutSubView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dateView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    override func bindViewModel() {
        searchBtn.rx.tap.map{ !self.dateView.isHidden }.bind(to: dateView.rx.isHidden).disposed(by: rx.disposeBag)
        
        
        guard let viewModel = viewModel as? ZKDepositRecordViewModel else { return }
        
        let input = ZKDepositRecordViewModel.Input(headerRefresh: tableView.mj_header!.rx.refreshing.asObservable(),
                                                   loadMore: tableView.mj_footer!.rx.refreshing.asObservable(),
                                                   startDateTap: dateView.startBtn.rx.tap(),
                                                   endDateTap: dateView.endBtn.rx.tap(),
                                                   searchTap: dateView.searchBtn.rx.tap.asObservable()
        )
            
        let output = viewModel.transform(input: input)
        output.depositList.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.time.drive(headerView.timelab.rx.text).disposed(by: rx.disposeBag)
        output.hasData.drive(tableView.backgroundView!.rx.isHidden).disposed(by: rx.disposeBag)
        
        viewModel.headerLoading.asObservable().bind(to: tableView.mj_header!.rx.endRefreshing).disposed(by: rx.disposeBag)
        viewModel.footerLoading.asObservable().bind(to: tableView.mj_footer!.rx.endRefreshing).disposed(by: rx.disposeBag)
        
        viewModel.startTime.bind(to: dateView.startBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.endTime.bind(to: dateView.endBtn.textLab.rx.text).disposed(by: rx.disposeBag)
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


class ZKDepositRecordHeader: ZKView {
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge14".wlLocalized
        return lab
    }()
    
    let timelab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(12)
        lab.text = "type2Txt1".wlLocalized
        return lab
    }()
    
    override func makeUI() {
        backgroundColor = .white
        
        addSubview(titleLab)
        addSubview(timelab)
        
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(26)
            make.centerY.equalToSuperview()
        }
        
        timelab.snp.makeConstraints { make in
            make.right.equalTo(-26)
            make.centerY.equalToSuperview()
        }
    }
}
