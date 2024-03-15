//
//  ZKAddBankCardViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/22
//  
//
    

import UIKit

class ZKAddBankCardViewController: ZKScrollViewController {

    let cardNameField: ZKLocalInputField = {
        let view = ZKLocalInputField(title: "card7".wlLocalized)
        view.contentView.backgroundColor = .white
        return view
    }()
    
    
    
    let bankNameField: ZKLocalInputField = {
        let view = ZKLocalInputField(title: "card8".wlLocalized)
        view.contentView.backgroundColor = .white
        view.mordIcon.isHidden = false
        view.defaltView.isUserInteractionEnabled = false
        return view
    }()
    
    let zhiField: ZKLocalInputField = {
        let view = ZKLocalInputField(title: "card9".wlLocalized)
        view.contentView.backgroundColor = .white
        view.hitIcon.isHidden = false
        view.hitLab.isHidden = false
        view.hitLab.textColor = UIColor(hexString: "#72788B")
        view.hitLab.text = "card13".wlLocalized
        return view
    }()
    
    let accountField: ZKLocalInputField = {
        let view = ZKLocalInputField(title: "card10".wlLocalized)
        view.contentView.backgroundColor = .white
        view.hitIcon.isHidden = false
        view.hitLab.isHidden = false
        view.hitLab.textColor = UIColor(hexString: "#72788B")
        view.hitLab.text = "card14".wlLocalized
        return view
    }()
    
//    let provinceField: ZKLocalInputField = {
//        let view = ZKLocalInputField(title: "开户省份")
//        view.contentView.backgroundColor = .white
//        view.hitIcon.isHidden = false
//        view.hitLab.isHidden = false
//        view.hitLab.textColor = UIColor(hexString: "#72788B")
//        view.hitLab.text = "必须与您申请银行账号的省份相同"
//        return view
//    }()
//
//    let cityField: ZKLocalInputField = {
//        let view = ZKLocalInputField(title: "开户城市")
//        view.contentView.backgroundColor = .white
//        view.hitIcon.isHidden = false
//        view.hitLab.isHidden = false
//        view.hitLab.textColor = UIColor(hexString: "#72788B")
//        view.hitLab.text = "必须与您申请银行账号的城市相同"
//        return view
//    }()
    
    let submitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 343, height: 44))
        bg.cornerRadius = 5
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("card6".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        title = "account9Txt".wlLocalized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func initSubView() {
        super.initSubView()
        
        contentView.addSubview(cardNameField)
        contentView.addSubview(bankNameField)
        contentView.addSubview(zhiField)
        contentView.addSubview(accountField)
//        contentView.addSubview(provinceField)
//        contentView.addSubview(cityField)
        contentView.addSubview(submitBtn)
        
        
        
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        cardNameField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.right.equalTo(-16)
        }
        bankNameField.snp.makeConstraints { make in
            make.left.right.equalTo(cardNameField)
            make.top.equalTo(cardNameField.snp.bottom)
        }
        
        accountField.snp.makeConstraints { make in
            make.left.right.equalTo(cardNameField)
            make.top.equalTo(bankNameField.snp.bottom)
        }
        
        zhiField.snp.makeConstraints { make in
            make.left.right.equalTo(cardNameField)
            make.top.equalTo(accountField.snp.bottom)
        }
//        provinceField.snp.makeConstraints { make in
//            make.left.right.equalTo(cardNameField)
//            make.top.equalTo(accountField.snp.bottom)
//        }
//        cityField.snp.makeConstraints { make in
//            make.left.right.equalTo(cardNameField)
//            make.top.equalTo(provinceField.snp.bottom)
//        }
        
        submitBtn.snp.makeConstraints { make in
            make.left.right.equalTo(cardNameField)
            make.top.equalTo(zhiField.snp.bottom).offset(25)
            make.bottom.equalTo(-96)
        }
    }
    

    override func bindViewModel() {
        guard let viewModel = viewModel as? ZKAddBankCardViewModel else { return  }
        let input = ZKAddBankCardViewModel.Input(name: cardNameField.rx.text.orEmpty.asObservable(),
                                                 depositBank: zhiField.rx.text.orEmpty.asObservable(),
                                                 account: accountField.rx.text.orEmpty.asObservable(),
//                                                 province: provinceField.rx.text.orEmpty.asObservable(),
//                                                 city: cityField.rx.text.orEmpty.asObservable(),
                                                 addTap: submitBtn.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        output.validatedSelectBank.drive(bankNameField.rx.validatedResult).disposed(by: rx.disposeBag)
        output.addResult.drive { [weak self] result in
            guard let self = self else {
                return
            }
            
            DefaultWireFrame.showPrompt(text: result.message ?? "")
            switch result {
            case .respone:
                self.navigator.pop(sender: self)
            default:
                break
            }
        
            
        }.disposed(by: rx.disposeBag)
        
        
        viewModel.selectBank.unwrap().bind { [weak self] bank in
            guard let self = self else { return }
            self.bankNameField.defaltView.titleLab.text = bank.name
            
        }.disposed(by: rx.disposeBag)
        
        bankNameField.contentView.rx.tap().bind { [weak self]  in
            guard let self = self else { return  }
            let view = self.bankNameField.contentView
            let selectView = ZKSelectListView.show(to: view, position: .bottom, width: view.width)
            output.bankList.drive(selectView.items).disposed(by: selectView.rx.disposeBag)
            selectView.tableView.rx.itemSelected.map{ $0.row }.map{ viewModel.bankList.value[$0] }.bind(to: viewModel.selectBank).disposed(by: selectView.rx.disposeBag)
        }.disposed(by: rx.disposeBag)
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
