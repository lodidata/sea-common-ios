//
//  WLIntegralHistoryController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit

class WLIntegralHistoryController: ZKViewController {

    var rightBtn: UIButton = UIButton.init(type: .custom)
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
    private lazy var dateView: WLDateShowView = {
        let aView = WLDateShowView()
        return aView
    }()
    private lazy var topView: WLWithdrawRecordTopView = {
        let aView = WLWithdrawRecordTopView()
        aView.isHidden = true
        return aView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.isHidden = true
        tableView.backgroundView = noDataView
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        start_time = formatter.string(from: Date())
        end_time = formatter.string(from: Date())
        dateView.startView.dateLab.text = start_time
        dateView.endView.dateLab.text = end_time
        topView.startBtn.setTitle(start_time, for: .normal)
        topView.endBtn.setTitle(end_time, for: .normal)
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(dateView)
        view.addSubview(topView)
        view.addSubview(tableView)
    }

    override func layoutSubView() {
        super.layoutSubView()
        dateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(170)
        }
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        dateView.startView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 1
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        dateView.endView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                UIApplication.appDeltegate.window?.addSubview(datePickView)
                datePickView.tag = 2
                self.datePickView.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }.disposed(by: rx.disposeBag)
        dateView.queryBtn.rx.tap.bind { [unowned self] _ in
            dateView.isHidden = true
            topView.isHidden = false
            tableView.isHidden = false
        }.disposed(by: rx.disposeBag)
        
        rightBtn.rx.tap.bind { [unowned self] _ in
            dateView.isHidden = false
            topView.isHidden = true
            tableView.isHidden = true
        }.disposed(by: rx.disposeBag)
    }
    
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
            self.dateView.startView.dateLab.text = start_time
        } else {
            end_time = self.chooseDate
            self.topView.endBtn.setTitle(end_time, for: .normal)
            self.dateView.endView.dateLab.text = end_time
        }
    }

}
