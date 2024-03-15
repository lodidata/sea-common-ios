//
//  WLDiscountController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/13.
//

import UIKit
import SwiftyJSON
import MJRefresh

class WLDiscountController: ZKViewController {

    private var dataList: [WLUserActiveListDataModel] = []
    private var typesList: [WLUserActiveTypesDataModel] = []
    private var mj_header: MJRefreshNormalHeader?
    private var typeId: Int = 0
    private lazy var navView: WLDiscountNavView = {
        let navView = WLDiscountNavView.init()
        navView.icon.image = UIImage.init(named: "discount_nav_icon")
        navView.titleLab.text = "discount0".wlLocalized
        return navView
    }()
    private lazy var topView: WLDiscountTypeView = {
        let aView = WLDiscountTypeView()
        aView.bgView.isHidden = true
        aView.selectBlock = { [weak self] id in
            self?.topView.snp.updateConstraints { make in
                make.height.equalTo(42)
            }
            self?.typeId = id
            self?.requestDiscount(id)
        }
        return aView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(WLDiscountCell.self, forCellReuseIdentifier: "discount")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 152
        tableView.backgroundColor = UIColor.init(hexString: "0E0D20")
        return tableView
    }()
    private lazy var noDataView: NoDataView = {
        let aView = NoDataView()
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(hexString: "0E0D20")
        requestDiscount(0)
        requestTypes()
    }
    
    override func initSubView() {
        view.addSubview(navView)
        view.addSubview(topView)
        view.addSubview(tableView)
        setMj_header()
    }
    override func layoutSubView() {
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(NAV_HEIGHT)
            make.top.equalTo(0)
        }
        topView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(42)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(topView)
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }

    override func bindViewModel() {
        
        topView.topView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                if self.typesList.count == 0 {
                    self.showHUDMessage("txt1".wlLocalized)
                    self.requestTypes()
                    return
                }
                self.topView.bgView.isHidden = !self.topView.bgView.isHidden
                if self.topView.bgView.isHidden {
                    topView.snp.updateConstraints { make in
                        make.height.equalTo(42)
                    }
                } else {
                    topView.snp.updateConstraints { make in
                        if self.typesList.count <= 6 {
                            make.height.equalTo(40 * self.typesList.count + 42)
                        } else {
                            make.height.equalTo(260 + 42)
                        }
                    }
                }
            }.disposed(by: rx.disposeBag)
    }
    func setMj_header() {
        self.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        self.tableView.mj_header = self.mj_header
    }
    @objc func refreshData() {
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "refresh_queue1")
        let queue2 = DispatchQueue(label: "refresh_queue2")
        
        group.enter()
        queue1.async {
            self.requestDiscount(self.typeId)
            group.leave()
        }
        group.enter()
        queue2.async {
            self.requestTypes()
            group.leave()
        }
        
        group.wait()
        self.mj_header?.endRefreshing()
    }
}
extension WLDiscountController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discount") as! WLDiscountCell
        if indexPath.row < dataList.count {
            cell.imgStr = dataList[indexPath.row].img
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVc = WLDiscountDetailController()
        detailVc.dataModel = dataList[indexPath.row]
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
}

extension WLDiscountController {
    func requestDiscount(_ typeId: Int) {
        WLProvider.request(.userActiveList(active_type_id: typeId)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel: [WLUserActiveListDataModel] = Array(JSONString: json["data"][0]["data"].rawString() ?? "") {
                            self.dataList = dataModel
                            self.tableView.reloadData()
                            self.tableView.backgroundView = nil
                        } else {
                            self.dataList.removeAll()
                            self.tableView.reloadData()
                            self.tableView.backgroundView = self.noDataView
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    func requestTypes() {
        WLProvider.request(.userActiveTypes) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        if let dataModel: [WLUserActiveTypesDataModel] = Array(JSONString: json["data"].rawString() ?? "") {
                            self.typesList = dataModel
                            self.topView.dataList = dataModel
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
