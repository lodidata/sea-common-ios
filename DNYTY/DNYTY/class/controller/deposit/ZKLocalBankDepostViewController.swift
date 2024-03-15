//
//  ZKLocalBankDepostViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit
import LiveChat

class ZKLocalBankDepostViewController: ZKScrollViewController {
    
    let bankAccountView = ZKLocalBankAccountView()
    let inView = ZKLocalInputView()
    
    let hitBtn: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: RImage.pay_hit_btn(), style: .plain, target: nil, action: nil)
        return barButtonItem
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "recharge5".wlLocalized

        // Do any additional setup after loading the view.
    }
    
    override func initSubView() {
        super.initSubView()
        contentView.backgroundColor = UIColor(hexString: "#EDEEF3")
        
        contentView.addSubview(bankAccountView)
        contentView.addSubview(inView)
        
        
        
        
        
        self.navigationItem.rightBarButtonItem = hitBtn
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
        bankAccountView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)

        }
        
        inView.snp.makeConstraints { make in
            make.left.right.equalTo(bankAccountView)
            make.top.equalTo(bankAccountView.snp.bottom).offset(12)
        }
        
       
        
        
    }

    override func bindViewModel() {
        hitBtn.rx.tap.bind{[weak self] in
            self?.navigator.show(segue: .payHelp, sender: self, transition: .modal)
        }.disposed(by: rx.disposeBag)
        
        
        guard let viewModel = viewModel as? ZKLocalBankDepostViewModel else { return  }
        viewModel.indicator.asDriver().drive(rx.loading).disposed(by: rx.disposeBag)
        let input = ZKLocalBankDepostViewModel.Input(viewWillShow: rx.viewDidAppear.mapToVoid(),
                                                     bankSelectIndex: bankAccountView.collectionView.rx.currentIndex,
                                                     name: inView.nameField.rx.text.orEmpty.asObservable(),
                                                     money: inView.moneyField.rx.text.orEmpty.asObservable(),
                                                     submitTap: inView.submitBtn.rx.tap.asObservable(),
                                                     kefuTap: inView.kefuTap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.bankList.map{ $0.map{ ZKLocalBankAccountView.ZKBankAccountCellViewModel(bank: $0) } }.drive(bankAccountView.items).disposed(by: rx.disposeBag)
        output.validatedBindCard.drive(inView.bankField.rx.validatedResult).disposed(by: rx.disposeBag)
        output.validatedBindCard.drive(inView.bankAccountField.rx.validatedResult).disposed(by: rx.disposeBag)
        output.validatedName.drive(inView.nameField.rx.validatedResult).disposed(by: rx.disposeBag)
        output.validatedMoney.drive(inView.moneyField.rx.validatedResult).disposed(by: rx.disposeBag)
        output.depositResult.drive { result in
            DefaultWireFrame.showPrompt(text: result.message ?? "")
        }.disposed(by: rx.disposeBag)
        output.openKefu.drive {_ in
            LiveChat.presentChat()
        }.disposed(by: rx.disposeBag)
        
        viewModel.selectCard.unwrap().bind { [weak self] bank in
            guard let self = self else { return }
            self.inView.bankField.text = bank.bankName
            self.inView.bankAccountField.text = bank.account
        }.disposed(by: rx.disposeBag)
        
        viewModel.selectDate.bind(to: inView.dateSelectItems.dateBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.selectHour.bind(to: inView.dateSelectItems.hourBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        viewModel.selectMinute.bind(to: inView.dateSelectItems.minuteBtn.textLab.rx.text).disposed(by: rx.disposeBag)
        
        inView.bankField.contentView.rx.tap().bind { [weak self]  in
            guard let self = self else { return  }
            if viewModel.binkCardList.value.count == 0 {
                self.navigator.show(segue: .addBankCard, sender: self)
                return
            }
            
            let view = self.inView.bankField.contentView
            let selectView = ZKSelectListView.show(to: view, position: .bottom, width: view.width)
            viewModel.binkCardList.map{ $0.map{ $0.bankName } }.bind(to: selectView.items).disposed(by: selectView.rx.disposeBag)
            selectView.tableView.rx.itemSelected.map{ $0.row }.map{ viewModel.binkCardList.value[$0] }.bind(to: viewModel.selectCard).disposed(by: selectView.rx.disposeBag)
        }.disposed(by: rx.disposeBag)
        
        inView.dateSelectItems.dateBtn.rx.tap().flatMapLatest{ DefaultWireFrame.presetSelctData() }.map { dateComponents in
            String(format: "%d-%02d-%02d", dateComponents.year!, dateComponents.month!, dateComponents.day!)
        }.bind(to: viewModel.selectDate).disposed(by: rx.disposeBag)
        
        inView.dateSelectItems.hourBtn.rx.tap().bind { [weak self] in
            guard let self = self else { return  }
            let view = self.inView.dateSelectItems.hourBtn
            let selectView = ZKSelectListView.show(list: viewModel.hours, to: view, position: .top, width: view.width)
            selectView.tableView.rx.itemSelected.map{ $0.row }.map{ viewModel.hours[$0] }.bind(to: viewModel.selectHour).disposed(by: selectView.rx.disposeBag)
        }.disposed(by: rx.disposeBag)
        
        inView.dateSelectItems.minuteBtn.rx.tap().bind { [weak self] in
            guard let self = self else { return  }
            let view = self.inView.dateSelectItems.minuteBtn
            let selectView = ZKSelectListView.show(list: viewModel.minutes, to: view, position: .top, width: view.width)
            selectView.tableView.rx.itemSelected.map{ $0.row }.map{ viewModel.minutes[$0] }.bind(to: viewModel.selectMinute).disposed(by: selectView.rx.disposeBag)
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
