//
//  ZLAlertViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/22
//  
//
    

import UIKit

class ZKAlertViewController: ZKViewController {
    
    let contentView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(20)
        lab.text = "card17".wlLocalized
        return lab
    }()
    
    let textLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.text = "card18".wlLocalized
        lab.textColor = UIColor(hexString: "#30333A")
        lab.numberOfLines = 0
        lab.font = kMediumFont(14)
        lab.text = "card17".wlLocalized
        return lab
    }()
    
    var closeBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(RImage.noti_close1(), for: .normal)
        return btn
    }()
    
    let cacelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = CALayer()
        bg.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        bg.backgroundColor = UIColor(hexString: "#28273E")?.cgColor
        bg.cornerRadius = 5
    
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("card19".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(16)
        return btn
    }()
    
    let confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bg = kSubmitButtonLayer1(size: CGSize(width: 150, height: 44))
        bg.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        bg.backgroundColor = UIColor(hexString: "#28273E")?.cgColor
        bg.cornerRadius = 5
    
        btn.setBackgroundImage(bg.snapshotImage(), for: .normal)
        btn.setTitle("card20".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kSystemFont(16)
        return btn
    }()
    
    init(content: String) {
        super.init(nibName: nil, bundle: nil)
        textLab.text = content
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hero.isEnabled = true
        contentView.hero.modifiers = [.translate( y: -200), .fade]
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
    }
    
    
    override func initSubView() {
        view.addSubview(contentView)
        
        contentView.addSubview(closeBtn)
        contentView.addSubview(titleLab)
        contentView.addSubview(textLab)
        contentView.addSubview(cacelBtn)
        contentView.addSubview(confirmBtn)
    }
    
    override func layoutSubView() {
        contentView.snp.makeConstraints { make in
            make.left.equalTo(17)
            make.right.equalTo(-17)
            make.centerY.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.right.equalTo(16)
            make.top.equalTo(16)
        }
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(15)
            make.right.lessThanOrEqualTo(-15)
        }
        
        textLab.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualTo(15)
            make.right.lessThanOrEqualTo(-15)
        }
        
        cacelBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(textLab.snp.bottom).offset(54)
            make.bottom.equalTo(-20)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.bottom.width.equalTo(cacelBtn)
        }
        
    }
    
    override func bindViewModel() {
        rx.submitResult.bind{ [weak self] _ in
            self?.dismiss(animated: true)
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


extension Reactive where Base: ZKAlertViewController {
    var submitResult: Observable<Bool> {
        let vc = self.base
        let cacel = vc.closeBtn.rx.tap.asObservable().merge(with: vc.cacelBtn.rx.tap.asObservable()).map{ false }
        let ok = vc.confirmBtn.rx.tap.asObservable().map{ true }
        return cacel.merge(with: ok)
    }
}
