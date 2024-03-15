//
//  WLBenefitInfoController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/23.
//

import UIKit

class WLBenefitInfoController: WLViewController {

    private var page: Int = 1
    private var mj_header: MJRefreshNormalHeader?
    private var mj_footer: MJRefreshAutoNormalFooter?
    private var dataList: [BenefitInfoModel]? = []
    private var selectList: [Int] = []
    private lazy var topView: WLNoticeActionView = {
        let aView = WLNoticeActionView()
        aView.isHidden = true
        return aView
    }()
    private lazy var nullView: NoDataView = {
        let aView = NoDataView()
        aView.icon.image = UIImage.init(named: "no_discount_icon")
        aView.lab.text = "accountDiscount0".wlLocalized
        return aView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(BenefitInfoCell.self, forCellReuseIdentifier: "benefit")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "EDEEF3")
        navView.titleLab.text = "account11".wlLocalized
        setMj_header_footer()
        //getNoticeList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNoticeList()
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(topView)
        view.addSubview(tableView)
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        //全选or全不选
        topView.isSelectAllBtn.rx.tap
            .bind { [unowned self] _ in
                topView.isSelectAllBtn.isSelected = !topView.isSelectAllBtn.isSelected
                if topView.isSelectAllBtn.isSelected {
                    selectList.removeAll()
                    selectList = Array.init(repeating: 1, count: dataList?.count ?? 0)
                } else {
                    selectList.removeAll()
                    selectList = Array.init(repeating: 0, count: dataList?.count ?? 0)
                }
                tableView.reloadData()
            }.disposed(by: rx.disposeBag)
        //已读
        topView.isReadBtn.rx.tap
            .bind { [unowned self] _ in
                let ids = getSelectIds()
                if ids.count > 0 {
                    let idsStr = ids.joined(separator: ",")
                    readRequest(ids: idsStr)
                }
            }.disposed(by: rx.disposeBag)
        //删除
        topView.isDeleteBtn.rx.tap
            .bind { [unowned self] _ in
                let ids = getSelectIds()
                if ids.count > 0 {
                    let idsStr = ids.joined(separator: ",")
                    deleteRequest(ids: idsStr)
                }
            }.disposed(by: rx.disposeBag)
    }
    func getSelectIds() -> [String] {
        var ids = [String]()
        for (index,item) in selectList.enumerated() {
            if item == 1 {
                let dataModel = dataList?[index]
                ids.append("\(dataModel?.id ?? 0)")
            }
        }
        return ids
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
        getNoticeList()
    }
    @objc func loadMoreData() {
        self.page = self.page + 1
        getNoticeList()
    }
    func mjFooterTitleForIdle() {
        if self.dataList?.count ?? 0 == 0 {
            self.mj_footer?.setTitle("", for: MJRefreshState.idle)
        } else {
            self.mj_footer?.setTitle("——— " + "noMore".wlLocalized + " ———", for: MJRefreshState.idle)
        }
    }
}

extension WLBenefitInfoController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "benefit") as! BenefitInfoCell
        cell.isSelectBtn.tag = indexPath.row
        cell.selectBlock = { [weak self] id in
            if id < self?.selectList.count ?? 0 {
                if self?.selectList[id] == 0 {
                    self?.selectList[id] = 1
                } else {
                    self?.selectList[id] = 0
                }
                self?.tableView.reloadData()
            }
            //如果有选中的，删除和已读按钮变为可点击
            if let selects = self?.selectList {
                var ids = [Int]()
                for item in selects {
                    if item == 1 {
                        //把选中的加进去
                        ids.append(item)
                    }
                }
                //说明有选中的,则把删除和已读变成可点击
                if ids.count > 0 {
                    self?.topView.isReadBtn.isEnabled = true
                    self?.topView.isDeleteBtn.isEnabled = true
                } else {
                    self?.topView.isReadBtn.isEnabled = false
                    self?.topView.isDeleteBtn.isEnabled = false
                }
                //说明全部选中了，则把上面的按钮变成选中
                if ids.count == selects.count {
                    self?.topView.isSelectAllBtn.isSelected = true
                } else {
                    self?.topView.isSelectAllBtn.isSelected = false
                }
            }
        }
        if indexPath.row < dataList?.count ?? 0 {
            cell.setBenefitDataModel(dataModel: dataList?[indexPath.row], isSelect: selectList[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVc = WLBenefitDetailController()
        if indexPath.row < dataList?.count ?? 0 {
            detailVc.dataModel = dataList?[indexPath.row]
        }
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

extension WLBenefitInfoController {
    func getNoticeList() {
        WLProvider.request(.messageList(type: nil, page: page, pageSize: 10)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let data: [BenefitInfoModel] = Array(JSONString: json["data"].rawString() ?? "") {
                            if self.page == 1 {
                                self.dataList?.removeAll()
                                self.selectList.removeAll()
                                self.topView.isSelectAllBtn.isSelected = false
                            }
                            data.forEach { dataModel in
                                self.dataList?.append(dataModel)
                                self.selectList.append(0)
                            }
                            self.tableView.reloadData()
                            self.topView.isHidden = false
                        }
                        self.mj_header?.endRefreshing()
                        self.mj_footer?.endRefreshing()
                        self.mjFooterTitleForIdle()
                        if self.dataList?.count ?? 0 == 0 {
                            self.dataList?.removeAll()
                            self.selectList.removeAll()
                            self.tableView.reloadData()
                            self.tableView.backgroundView = self.nullView
                            self.topView.isHidden = true
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func readRequest(ids: String) {
        WLProvider.request(.readMessage(ids: ids)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.showHUDMessage("new11".wlLocalized)
                        self.page = 1
                        self.getNoticeList()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func deleteRequest(ids: String) {
        WLProvider.request(.deleteMessage(ids: ids)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.showHUDMessage("new12".wlLocalized)
                        self.page = 1
                        self.getNoticeList()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
