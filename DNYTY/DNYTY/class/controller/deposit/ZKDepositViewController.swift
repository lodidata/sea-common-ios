//
//  ZKDepositViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit

class ZKDepositViewController: ZKViewController {
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A") ?? UIColor.black
        lab.font = kMediumFont(16)
        lab.text = "recharge0".wlLocalized
        return lab
    }()
    
    let walletView = ZKDepositWalletView()
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.rowHeight = 62
        tableView.register(ZKDepositModeCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKDepositMethod>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKDepositModeCell
        cell.icon.image = item.icon
        cell.titleLab.text = item.title
        cell.detailLab.text = item.detailTitle
        cell.detailLab.textColor = indexPath.row == 0 ? UIColor(hexString: "#115FAF") : UIColor(hexString: "#72788B")
        return cell
    }
    
    var recordBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 56, height: 20)
        btn.setTitle("recharge1".wlLocalized, for: .normal)
        btn.setTitleColor(UIColor(hexString: "#30333A"), for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLab.sizeToFit()
        navigationItem.titleView = titleLab
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !ZKLoginUser.shared.isLogin {
            self.navigator.show(segue: .login, sender: self)
        }
    }
    
    override func initSubView() {
        
        view.addSubview(walletView)
        view.addSubview(tableView)
        
        
        
        
        let item = UIBarButtonItem(customView: recordBtn)
        navigationItem.rightBarButtonItem = item
    }
    
    override func layoutSubView() {
        walletView.snp.makeConstraints { make in
            make.left.equalTo(6)
            make.right.equalTo(-6)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(self.walletView.snp.width).multipliedBy(101.0/363)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.top.equalTo(walletView.snp.bottom)
            make.right.equalTo(-8)
            make.bottom.equalToSuperview()
        }
    }

    
    override func bindViewModel() {
        
        recordBtn.rx.tap.bind { [weak self] in
            self?.navigator.show(segue: .depositRecord, sender: self)
        }.disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKDepositViewModel else { return }
        let input = ZKDepositViewModel.Input(viewWillShow: rx.viewWillAppear.mapToVoid())
        let output = viewModel.transform(input: input)
        output.depositMethods.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.account.drive(walletView.accountLab.rx.text).disposed(by: rx.disposeBag)
        output.money.drive(walletView.moneyLab.rx.text).disposed(by: rx.disposeBag)
        
        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(ZKDepositMethod.self).bind {[weak self] type in
            guard let self = self else { return }
            switch type {
            case .gcash:
                self.navigator.show(segue: .gcashDeposit, sender: self)
            case .card:
                self.navigator.show(segue: .cardDeposit, sender: self)
            case .localBank:
                self.navigator.show(segue: .localBankDeposit, sender: self)
            case .autoTopup:
                self.navigator.show(segue: .autoTopup, sender: self)
            
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
