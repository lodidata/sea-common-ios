//
//  ZKBankCardViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/21
//  
//
    

import UIKit

class ZKBankCardViewController: ZKViewController, UITableViewDelegate {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZKBankCardCellViewModel>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKBankCardTableViewCell
        cell.bankLab.text = item.bank
        cell.nameLab.text = item.name
        cell.accountLab.text = item.account
        return cell
    }


    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .grouped)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = UIColor(hexString: "#EDEEF3")
        tableView.register(ZKBankCardTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0.1))
        //tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let addView = ZKAddCardButtonView(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 32, height: (kScreenWidth - 32)*140.0/343))

    override func viewDidLoad() {
        super.viewDidLoad()

        //automaticallyAdjustsScrollViewInsets = false
        title = "card5".wlLocalized
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func initSubView() {

        tableView.delegate = self
        view.addSubview(tableView)

        tableView.tableFooterView = addView

    }

    override func layoutSubView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        
    }

    override func bindViewModel() {
        addView.rx.tap().bind { [weak self] in
            guard let self = self else {
                return
            }
            self.navigator.show(segue: .addBankCard, sender: self)
            
        }.disposed(by: rx.disposeBag)
        guard let viewModel = viewModel as? ZKBankCardViewModel else { return  }
        let input = ZKBankCardViewModel.Input(viewWillShow: rx.viewWillAppear.mapToVoid()
                                               )
        let output = viewModel.transform(input: input)
        
        output.cardList.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        output.deleteResult.drive { msg in
            DefaultWireFrame.showPrompt(text: msg)
        }.disposed(by: rx.disposeBag)
        
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { _, view, succes in
            
            guard let viewModel = try? self.dataSource.model(at: indexPath) as? ZKBankCardCellViewModel else { return }
            viewModel.deleteTap.accept(())
            succes(true)
        }
        deleteAction.image = RImage.delete_btn1()
        deleteAction.backgroundColor = UIColor(hexString: "#E94951")
        let antions = UISwipeActionsConfiguration(actions: [deleteAction])
        return antions
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
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

