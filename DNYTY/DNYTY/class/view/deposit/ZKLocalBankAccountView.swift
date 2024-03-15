//
//  ZKLocalBankAccountView.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import UIKit
import RxRelay

class ZKLocalBankAccountView: ZKView, UICollectionViewDelegateFlowLayout {
    typealias Bank = ZKWalletServer.BankInfo
    struct ZKBankAccountCellViewModel {
        let bankName: String
        let name: String
        let card: String
        let qrCodeUrl: URL?
        let bank: Bank
        init(bank: Bank) {
            self.bank = bank
            bankName = bank.bankName
            name = bank.name
            card = bank.card
            qrCodeUrl = bank.qrCodeUrl
        }
    }
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, ZKBankAccountCellViewModel>>(configureCell: { dataSource, collectionView, indexPath, info in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKLocalBankAccountCell
        cell.bankLab.text = info.bankName
        cell.nameLab.text = info.name
        cell.accountLab.text = info.card
        cell.qrCode.sd_setImage(with: info.qrCodeUrl)
        cell.copyBtn.rx.tap.bind {
            UIPasteboard.general.string = info.bank.card
            DefaultWireFrame.showPrompt(text: "new8".wlLocalized)
        }.disposed(by: cell.disposedBag)
        
        return cell
        
    })
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(ZKLocalBankAccountCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(16)
        lab.text = "Deposit bank"
        return lab
    }()
    
    let items: PublishRelay<[ZKBankAccountCellViewModel]> = PublishRelay()
    
    override func makeUI() {
        backgroundColor = .white
        layer.cornerRadius = 5
        
        addSubview(titleLab)
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        addSubview(line)
        addSubview(collectionView)
        
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.right.equalTo(-16)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom).offset(9)
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(titleLab)
            make.top.equalTo(line.snp.bottom).offset(16)
            make.height.equalTo(300)
            make.bottom.equalTo(-20)
        }
        
        
        
        collectionView.delegate = self
        
        items.map{ [SectionModel(model: "", items: $0)] }.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.width, height: 300)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class ZKLocalBankAccountCell: UICollectionViewCell {
    var disposedBag = DisposeBag()
    
    let bankTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "depositBank1".wlLocalized + ":"
        //lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let nameTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "depositBank2".wlLocalized + ":"
        lab.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let accountTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "depositBank3".wlLocalized + ":"
        lab.setContentHuggingPriority(.defaultLow, for: .horizontal)
        //lab.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return lab
    }()
    
    let bankLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "AUB"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    let nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "novo hermosilla flores"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    let accountLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.text = "09063364388"
        lab.font = kMediumFont(12)
        lab.textAlignment = .left
        return lab
    }()
    
    
    
    let qrCode: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = UIColor(hexString: "#EDEEF3")
        return imgV
    }()

    let copyBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bgLay = kSubmitButtonLayer1(size: CGSize(width: 311, height: 36))
        bgLay.cornerRadius = 5
        btn.setBackgroundImage(bgLay.snapshotImage(), for: .normal)
        btn.setTitle("agency43".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(14)
        return btn
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposedBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = UIColor(hexString: "#EDEEF3")
        
        let topContentView = UIView()
        topContentView.layer.cornerRadius = 2
        topContentView.backgroundColor = UIColor(hexString: "#EDEEF3")
        contentView.addSubview(topContentView)
        contentView.addSubview(qrCode)
        contentView.addSubview(copyBtn)
        
        topContentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(68)
        }
        
        qrCode.snp.makeConstraints { make in
            make.top.equalTo(topContentView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 155, height: 155))
        }
        
        copyBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(qrCode.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
        
       
        
        topContentView.addSubview(bankTitleLab)
        topContentView.addSubview(nameTitleLab)
        topContentView.addSubview(accountTitleLab)
        
        topContentView.addSubview(bankLab)
        topContentView.addSubview(nameLab)
        topContentView.addSubview(accountLab)
        
        bankTitleLab.snp.makeConstraints { make in
            make.left.equalTo(13)
            make.top.equalTo(8)
            
        }
        nameTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(bankTitleLab.snp.bottom).offset(5)
        }
        
        accountTitleLab.snp.makeConstraints { make in
            make.left.equalTo(bankTitleLab)
            make.top.equalTo(nameTitleLab.snp.bottom).offset(5)
            make.bottom.equalTo(-8)
        }
        
        bankLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(bankTitleLab)
            make.right.equalTo(-20)
        }
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(nameTitleLab)
            make.right.equalTo(-20)
        }
        
        accountLab.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLab.snp.right).offset(5)
            make.centerY.equalTo(accountTitleLab)
            make.right.equalTo(-20)
        }
        
        copyBtn.rx.tap.bind { [weak self] in
            guard let self = self, let account = self.accountLab.text, !account.isEmpty else { return }
            UIPasteboard.general.string = account
            DefaultWireFrame.showPrompt(text: "new8".wlLocalized)
        }.disposed(by: rx.disposeBag)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

