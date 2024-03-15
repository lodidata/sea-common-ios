//
//  ZKGcashTableViewCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit
import RxRelay

class ZKGcashDepositInputCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    let topView = ZKDepositShowView()
    let inView = ZKDepositInputView()
    
    let bottomView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    let submitBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let bgl = kSubmitButtonLayer1(size: CGSize(width: 323, height: 44))
        bgl.cornerRadius = 5
        btn.setBackgroundImage(bgl.snapshotImage(), for: .normal)
        btn.setTitle("recharge21".wlLocalized, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = kMediumFont(16)
        
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor(hexString: "#EDEEF3")
        layer.cornerRadius = 6
        
        
        let myContentView = UIView()
        myContentView.backgroundColor = .white
        myContentView.layer.cornerRadius = 10
        myContentView.layer.shadowColor = UIColor(white: 0, alpha: 0.2).cgColor
        myContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        myContentView.layer.shadowOpacity = 1

        
        contentView.addSubview(myContentView)
        myContentView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        }
        
        myContentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        

        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(bottomView)
        bottomView.addArrangedSubview(inView)
        bottomView.addArrangedSubview(submitBtn)
        
        
        
        submitBtn.snp.makeConstraints { make in
            make.height.equalTo(submitBtn.snp.width).multipliedBy(44.0/323)
        }
        
        

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}




class ZKDepositShowView: ZKView {
    
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.gcash())
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        lab.text = "GCash"
        return lab
    }()
    
    let detailLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge22".wlLocalized + " - "
        return lab
    }()
    
 
    let chargeTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge17".wlLocalized + ":"
        return lab
    }()
    
    let chargeLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge18".wlLocalized
        return lab
    }()
    
    let showBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isUserInteractionEnabled = false
        btn.setImage(RImage.list_show_d(), for: .normal)
        btn.setImage(RImage.list_show_s(), for: .selected)
        return btn
    }()
    
    override func makeUI() {
        addSubview(icon)
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(showBtn)
        addSubview(chargeTitleLab)
        addSubview(chargeLab)
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(icon.snp.height)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.bottom.equalTo(self.snp.centerY).offset(-2)
        }
        
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(self.snp.centerY).offset(2)
        }
        
        showBtn.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.centerY.equalToSuperview()
        }
        
        chargeTitleLab.snp.makeConstraints { make in
            make.right.equalTo(showBtn.snp.left).offset(-5)
            make.bottom.equalTo(self.snp.centerY).offset(-2)
        }
        chargeLab.snp.makeConstraints { make in
            make.right.equalTo(chargeTitleLab)
            make.top.equalTo(self.snp.centerY).offset(2)
        }
        
       
    }
}


class ZKDepositInputView: ZKView, UICollectionViewDelegateFlowLayout {
    
    
    var numbers: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#E8E9F0")?.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    let moneyField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "finance16".wlLocalized
        textField.textColor = UIColor(hexString: "#30333A")
        textField.font = kMediumFont(12)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var rowCount: Int = 0 {
        didSet {
            collectionView.snp.remakeConstraints { make in
                make.left.equalTo(17)
                make.right.equalTo(-17)
                make.top.equalTo(line.snp.bottom).offset(9)
                let rowCount = Double(rowCount)
                let space = 5.0
                make.height.equalTo(collectionView.snp.width).multipliedBy(32.0/291 * rowCount).offset(space * (rowCount - 1))
            }
        }
    }
    let line = UIView()
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ZKDepositNumberCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    let moneyLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge19".wlLocalized + ":"
        return lab
    }()
    
    override func makeUI() {
        collectionView.delegate = self
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(moneyField)
        moneyField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(17)
            make.height.equalTo(50)
            make.right.equalTo(-17)
        }
        
        
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(moneyField.snp.bottom)
        }
        
        contentView.addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(17)
            make.right.equalTo(-17)
            make.top.equalTo(line.snp.bottom).offset(9)
            make.height.equalTo(0)
        }
        
        contentView.addSubview(moneyLab)
        
        moneyLab.snp.makeConstraints { make in
            make.left.equalTo(collectionView)
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
        }

        numbers.bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: ZKDepositNumberCell.self)) { _, number, cell in
            cell.textLab.text = number
        }.disposed(by: rx.disposeBag)
        
//        Observable.just([SectionModel(model: "", items: numbers)]).bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        let selectMoney = collectionView.rx.modelSelected(String.self).asObservable().share()
        selectMoney.bind(to: moneyField.rx.text).disposed(by: rx.disposeBag)
        
        rx.money.map{ text in
            "recharge19".wlLocalized + ":" + text
        }.bind(to: moneyLab.rx.text).disposed(by: rx.disposeBag)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.width - 15)/4 - 3
        return CGSize(width: width, height: width * 32/69)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}

extension Reactive where Base: ZKDepositInputView {
    
    var money: Observable<String> {
        let selectMoney = self.base.collectionView.rx.modelSelected(String.self).asObservable().share()
        return self.base.moneyField.rx.text.orEmpty.asObservable().merge(with: selectMoney).map { text in
            text.isEmpty ? "0": text
        }
    }
}

class ZKDepositNumberCell: UICollectionViewCell {
    let textLab: UILabel = {
       let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = UIColor(hexString: "#30333A")
        
        lab.font = kMediumFont(12)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "#D6D9E3")?.cgColor
        
        
        
        contentView.addSubview(textLab)
       
        
        textLab.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ? UIColor(hexString: "#7F4FE8")?.cgColor : UIColor(hexString: "#D6D9E3")?.cgColor
            self.textLab.textColor = isSelected ? UIColor(hexString: "#7F4FE8") : UIColor(hexString: "#30333A")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
