//
//  WLGameRecordController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/23.
//

import UIKit
import MJRefresh
import SwiftDate

class WLGameRecordController: WLViewController {

    private var dataList: [WLGameRecordDataModel]? = []
    private var filterList: [WLUserAgentBettingFiterDataModel]? = []
    private var showTypeModel: WLUserAgentBettingFiterDataModel?
    private var page: Int = 1
    private var mj_header: MJRefreshNormalHeader?
    private var mj_footer: MJRefreshAutoNormalFooter?
    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        return dateFormmater
    }()
    private var start_time = ""
    private var end_time = ""
    private var chooseDate = ""
    private lazy var queryView: WLGameRecordQueryAlphaView = {
        let aView = WLGameRecordQueryAlphaView()
        aView.topView.startView.tag = 1
        aView.topView.endView.tag = 2
        aView.topView.typeListView.selectBlock = { [weak self] data in
            self?.showTypeModel = data
            self?.queryView.topView.typeListView.isHidden = true
            self?.queryView.topView.typeView.nameLab.text = self?.showTypeModel?.name
        }
        return aView
    }()
    private lazy var dateView: WLRecordDateView = {
        let aView = WLRecordDateView()
        aView.isHidden = true
        return aView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WLGameRecordCell.self, forCellReuseIdentifier: "record")
        tableView.rowHeight = 170
        tableView.isHidden = true
        return tableView
    }()
    private lazy var nullView: NoDataView = {
        let aView = NoDataView()
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.titleLab.text = "account14".wlLocalized
        navView.rightBtn.setImage(UIImage.init(named: "search_black"), for: .normal)
        navView.rightBtn.isHidden = true
        
        start_time = formatter.string(from: Date())
        end_time = formatter.string(from: Date())
        queryView.topView.startView.dateLab.text = start_time
        queryView.topView.endView.dateLab.text = end_time
        self.dateView.startLab.text = start_time
        self.dateView.endLab.text = end_time
        
        getUserAgentBettingFiter()
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(queryView)
        view.addSubview(dateView)
        view.addSubview(tableView)
        
        setMj_header_footer()
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        queryView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
        }
        dateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(dateView.snp.bottom)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        
        navView.rightBtn.rx.tap.bind { [unowned self] _ in
            queryView.isHidden = false
            view.bringSubviewToFront(queryView)
            navView.rightBtn.isHidden = true
            dateView.isHidden = true
            tableView.isHidden = true
        }.disposed(by: rx.disposeBag)
        //点击开始时间
        queryView.topView.startView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 1
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        //点击结束时间
        queryView.topView.endView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 2
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        //点击查询
        queryView.topView.queryBtn.rx.tap.bind { [unowned self] _ in
            queryView.isHidden = true
            navView.rightBtn.isHidden = false
            dateView.isHidden = false
            tableView.isHidden = false
            page = 1
            getGameRecordRequest()
        }.disposed(by: rx.disposeBag)
        //点击游戏类型
        queryView.topView.typeView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                queryView.topView.typeListView.isHidden = false
            }.disposed(by: rx.disposeBag)
        
    }
    
    func setMj_header_footer() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        self.mj_footer?.setTitle("loading", for: MJRefreshState.refreshing)
        self.mj_footer?.setTitle("——— " + "noMore".wlLocalized + " ———", for: MJRefreshState.idle)
        self.mj_footer?.stateLabel?.textColor = .white
        self.mj_footer?.tintColor = .white
        self.mj_footer?.stateLabel?.font = kSystemFont(13)
        self.tableView.mj_header = self.mj_header
        self.tableView.mj_footer = self.mj_footer
    }
    @objc func refreshData() {
        self.page = 1
        self.dataList?.removeAll()
        getGameRecordRequest()
    }
    @objc func loadMoreData() {
        self.page = self.page + 1
        getGameRecordRequest()
    }
    func mjFooterTitleForIdle() {
        if self.dataList?.count ?? 0 == 0 {
            self.mj_footer?.setTitle("", for: MJRefreshState.idle)
        } else {
            self.mj_footer?.setTitle("——— " + "noMore".wlLocalized + " ———", for: MJRefreshState.idle)
        }
    }

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
            self.queryView.topView.startView.dateLab.text = start_time
            self.dateView.startLab.text = start_time
        } else {
            end_time = self.chooseDate
            self.queryView.topView.endView.dateLab.text = end_time
            self.dateView.endLab.text = end_time
        }
    }
}

extension WLGameRecordController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "record") as! WLGameRecordCell
        if indexPath.row < dataList?.count ?? 0 {
            cell.dataModel = dataList?[indexPath.row]
            cell.copyBtn.rx.tap.bind { [unowned self] _ in
                UIPasteboard.general.string = dataList?[indexPath.row].order_number
                self.showHUDMessage("new8".wlLocalized)
            }.disposed(by: rx.disposeBag)
        }
        return cell
    }
}
extension WLGameRecordController {
    func getUserAgentBettingFiter(isFirst: Bool = true) {
        WLProvider.request(.wlbettingFiter) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let data: [WLUserAgentBettingFiterDataModel] = Array(JSONString: json["data"].rawString() ?? "") {
                            self.filterList = data
                            if isFirst && data.count > 0 {
                                if data.count > 0 {
                                    self.showTypeModel = data.first
                                    self.queryView.topView.typeView.nameLab.text = self.showTypeModel?.name
                                    
                                } else {
                                    self.queryView.topView.typeView.nameLab.text = "game1".wlLocalized
                                }
                            }
                            self.queryView.topView.typeListView.dataList = self.filterList
                        }
                        
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getGameRecordRequest() {
        WLProvider.request(.wlGameRecord(start_time: start_time, end_time: end_time, page: page, page_size: 20, type_name: showTypeModel?.type ?? "", category: showTypeModel?.category ?? "", key: "")) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let data: [WLGameRecordDataModel] = Array(JSONString: json["data"].rawString() ?? "") {
                            if self.page == 1 {
                                self.dataList?.removeAll()
                                
                            }
                            data.forEach { dataModel in
                                self.dataList?.append(dataModel)
                            }
                            self.tableView.reloadData()
                        }
                        self.mj_header?.endRefreshing()
                        self.mj_footer?.endRefreshing()
                        self.mjFooterTitleForIdle()
                        if self.dataList?.count ?? 0 == 0 {
                            self.dataList?.removeAll()
                            self.tableView.reloadData()
                            self.tableView.backgroundView = self.nullView
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
}
