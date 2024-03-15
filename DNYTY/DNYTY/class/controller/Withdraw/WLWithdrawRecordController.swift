//
//  WLWithdrawRecordController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/14.
//

import UIKit
import MJRefresh
import SwiftDate

class WLWithdrawRecordController: ZKViewController {

    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        return dateFormmater
    }()
    private var start_time = ""
    private var end_time = ""
    private var page: Int = 1
    private var mj_header: MJRefreshNormalHeader?
    private var mj_footer: MJRefreshAutoNormalFooter?
    private var dataList: [WLWalletWithdrawHistoryDataModel]? = []
    private var chooseDate = ""
    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View()
        aView.rightBtn.setImage(UIImage.init(named: "search_black"), for: .normal)
        aView.titleLab.text = "withdraw12".wlLocalized
        return aView
    }()
    private lazy var topView: WLWithdrawRecordTopView = {
        let aView = WLWithdrawRecordTopView()
//        aView.startBtn.tag = 1
//        aView.endBtn.tag = 2
        return aView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(WLWithdrawRecordCell.self, forCellReuseIdentifier: "record")
        tableView.rowHeight = 142
        tableView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        return tableView
    }()
    private lazy var queryView: WLWithdrawQueryAlphaView = {
        let aView = WLWithdrawQueryAlphaView()
        aView.topView.startView.tag = 1
        aView.topView.endView.tag = 2
        aView.isHidden = true
        return aView
    }()
    private lazy var noDataView: NoDataView = {
        let aView = NoDataView.init()
        return aView
    }()
    private lazy var datePickView: WLDatePickView = {
        let aView = WLDatePickView.init()
        aView.toolView.cancelBtn.addTarget(self, action: #selector(cancelActionInDatePickView), for: .touchUpInside)
        aView.toolView.comfirmBtn.addTarget(self, action: #selector(comfirmActionInDatePickView), for: .touchUpInside)
        aView.pickView.addTarget(self, action: #selector(chooseDateAction(datePicker:)), for: .valueChanged)
        aView.pickView.maximumDate = Date()
        aView.pickView.minimumDate = Date() - 61.days
        return aView
    }()
    @objc func chooseDateAction(datePicker: UIDatePicker) {
        let chooseDate = datePicker.date
        
        self.chooseDate = formatter.string(from: chooseDate)
    }
    @objc func cancelActionInDatePickView() {
        datePickView.removeFromSuperview()
    }
    @objc func comfirmActionInDatePickView() {
        datePickView.removeFromSuperview()
        if self.chooseDate.count == 0 {
            self.chooseDate = formatter.string(from: Date())
        }
        if datePickView.tag == 1 {
            start_time = self.chooseDate
            self.topView.startBtn.setTitle(start_time, for: .normal)
            queryView.topView.startView.dateLab.text = start_time
        } else {
            end_time = self.chooseDate
            self.topView.endBtn.setTitle(end_time, for: .normal)
            queryView.topView.endView.dateLab.text = end_time
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        start_time = formatter.string(from: Date())
        end_time = formatter.string(from: Date())
        topView.startBtn.setTitle(start_time, for: .normal)
        topView.endBtn.setTitle(end_time, for: .normal)
        queryView.topView.startView.dateLab.text = start_time
        queryView.topView.endView.dateLab.text = end_time
        
        setMj_header_footer()
        getWithdrawHistory()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(topView)
        view.addSubview(tableView)
        view.addSubview(queryView)
    }
    override func layoutSubView() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        queryView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }

    override func bindViewModel() {
        
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        navView.rightBtn.rx.tap.bind { [unowned self] _ in
            navView.rightBtn.isHidden = true
            queryView.isHidden = false
        }.disposed(by: rx.disposeBag)
        
        queryView.topView.startView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 1
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        queryView.topView.endView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 2
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        queryView.topView.queryBtn.rx.tap
            .bind { [unowned self] _ in
                queryView.isHidden = true
                navView.rightBtn.isHidden = false
                getWithdrawHistory()
            }.disposed(by: rx.disposeBag)
    }
    func setMj_header_footer() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        self.mj_footer?.setTitle("loading", for: MJRefreshState.refreshing)
        self.mj_footer?.setTitle("——— " + "noMore".wlLocalized + " ———", for: MJRefreshState.idle)
        self.mj_footer?.stateLabel?.textColor = UIColor.init(hexString: "72788B")
        self.mj_footer?.tintColor = UIColor.init(hexString: "72788B")
        self.mj_footer?.stateLabel?.font = kSystemFont(13)
        self.tableView.mj_header = self.mj_header
        self.tableView.mj_footer = self.mj_footer
    }
    @objc func refreshData() {
        self.page = 1
        self.dataList?.removeAll()
        getWithdrawHistory()
    }
    @objc func loadMoreData() {
        self.page = self.page + 1
        getWithdrawHistory()
    }
}

extension WLWithdrawRecordController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "record") as! WLWithdrawRecordCell
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
            cell.copyBtn.rx.tap.bind { [unowned self] _ in
                UIPasteboard.general.string = dataList?[indexPath.row].trade_no
                self.showHUDMessage("new8".wlLocalized)
            }.disposed(by: rx.disposeBag)
        }
        return cell
    }
    
}

extension WLWithdrawRecordController {
    func getWithdrawHistory() {
        WLProvider.request(.wlWithdrawHistory(start_time: start_time, end_time: end_time, page: page, page_size: 10)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let data: [WLWalletWithdrawHistoryDataModel] = Array(JSONString: json["data"].rawString() ?? "")  {
                            
                            if self.page == 1 {
                                self.dataList?.removeAll()
                                self.dataList = data
                            } else {
                                data.forEach { dataModel in
                                    self.dataList?.append(dataModel)
                                }
                            }
                            
                            self.tableView.reloadData()
                            
                        }
                    }
                    self.mj_header?.endRefreshing()
                    self.mj_footer?.endRefreshing()
                    self.mjFooterTitleForIdle()
                    if self.dataList?.count ?? 0 == 0 {
                        self.dataList?.removeAll()
                        self.tableView.reloadData()
                        self.tableView.backgroundView = self.noDataView
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func mjFooterTitleForIdle() {
        if self.dataList?.count ?? 0 == 0 {
            self.mj_footer?.setTitle("", for: MJRefreshState.idle)
        } else {
            self.mj_footer?.setTitle("——— " + "noMore".wlLocalized + " ———", for: MJRefreshState.idle)
        }
    }
}
