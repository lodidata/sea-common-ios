//
//  ZKGcashTableViewCell.swift
//  DNYTY
//
//  Created by WL on 2022/6/15
//  
//
    

import UIKit

class ZKCardDepositInputCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    let topView: ZKDepositShowView = {
        let view = ZKDepositShowView()
        view.icon.image = RImage.jiejika()
        return view
    }()
    let inView = ZKDepositInputView()
    
    let selectBank = ZKCardBankSelelctButton()
    
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
        bottomView.addArrangedSubview(selectBank)
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

class ZKCardBankSelelctButton: ZKView {
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.jiejika())
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#72788B")
        lab.font = kMediumFont(12)
        lab.text = "recharge20".wlLocalized
        return lab
    }()
    
    let detailLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(12)
        lab.text = ""
        lab.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return lab
    }()
    

    
    let showBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(RImage.h_ljt(), for: .normal)
        return btn
    }()
    
    override func makeUI() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "#E8E9F0")?.cgColor
        self.layer.cornerRadius = 6
        
        addSubview(icon)
        addSubview(titleLab)
        addSubview(detailLab)
        addSubview(showBtn)
       
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.width.equalTo(icon.snp.height)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.bottom.equalTo(self.snp.centerY).offset(-2)
        }
        
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(self.snp.centerY).offset(2)
            make.right.lessThanOrEqualTo(showBtn.snp.left).offset(-10)
        }
        
        showBtn.snp.makeConstraints { make in
            make.right.equalTo(-8)
            make.centerY.equalToSuperview()
        }
        
        
       
    }
}


