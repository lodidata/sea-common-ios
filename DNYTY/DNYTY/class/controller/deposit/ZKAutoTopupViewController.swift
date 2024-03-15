//
//  ZKAutoTopupViewController.swift
//  DNYTY
//
//  Created by WL on 2022/7/1
//  
//
    

import UIKit

class ZKAutoTopupViewController: ZKViewController {
    
    let titleBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .white
        btn.setTitle("Auto Topup", for: .normal)
        btn.setTitleColor(UIColor(hexString: "#7753E0"), for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(hexString: "#7F4FE8")?.cgColor
        btn.layer.cornerRadius = 6
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 41, bottom: 12, right: 41)
        return btn
    }()
    
    let hitBtn: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: RImage.pay_hit_btn(), style: .plain, target: nil, action: nil)
        return barButtonItem
    }()
    
    let autoTopupView = ZKAutoTopupView()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Auto Topup"
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        self.navigationItem.rightBarButtonItem = hitBtn
       
    }
    
    override func initSubView() {
        view.addSubview(titleBtn)
        view.addSubview(autoTopupView)
    }
    
    override func layoutSubView() {
        
        titleBtn.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)

        }
        
        autoTopupView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(titleBtn.snp.bottom).offset(16)
        }
        
    }
    
    override func bindViewModel() {
        hitBtn.rx.tap.bind{[weak self] in
            self?.navigator.show(segue: .payHelp, sender: self, transition: .modal)
        }.disposed(by: rx.disposeBag)
        
        guard let viewModel = viewModel as? ZKAutoTopupViewModel else { return  }
        let input = ZKAutoTopupViewModel.Input()
        let output = viewModel.transform(input: input)
        output.bankList.drive(autoTopupView.collectionView.rx.items(cellIdentifier: "cell", cellType: ZKAutoTopupCell.self)) { _, item, cell in
            cell.bankLab.text = item.bankName
            cell.nameLab.text = item.name
            cell.accountLab.text = item.card
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
