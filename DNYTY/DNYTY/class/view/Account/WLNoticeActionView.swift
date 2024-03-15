//
//  WLNoticeActionView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/22.
//

import UIKit

class WLNoticeActionView: UIView {

    lazy var isSelectAllBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "unSelect_icon"), for: .normal)
        btn.setImage(UIImage.init(named: "select_icon"), for: .selected)
        return btn
    }()
    lazy var isDeleteBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "undelete_icon"), for: .disabled)
        btn.setImage(UIImage.init(named: "delete_icon"), for: .normal)
        btn.isEnabled = false
        return btn
    }()
    lazy var isReadBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "read_unenble"), for: .disabled)
        btn.setImage(UIImage.init(named: "read_enble"), for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.init(hexString: "EDEEF3")
        addSubview(isSelectAllBtn)
        addSubview(isDeleteBtn)
        addSubview(isReadBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isSelectAllBtn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        isReadBtn.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
        }
        isDeleteBtn.snp.makeConstraints { make in
            make.right.equalTo(-70)
            make.centerY.equalToSuperview()
        }
    }
}

class NoticeCenterCell: UITableViewCell {
//    typealias SelectBtnClickdBlock = (_ id: Int) -> Void
//    var selectBlock: SelectBtnClickdBlock?
    private lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
//    lazy var isSelectBtn: UIButton = {
//        let btn = UIButton.init(type: .custom)
//        btn.setImage(UIImage.init(named: "unSelect_icon"), for: .normal)
//        btn.setImage(UIImage.init(named: "select_icon"), for: .selected)
//        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
//        return btn
//    }()
    
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        return lab
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(14)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 2
        return lab
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "arrow_right_list")
        img.contentMode = .center
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        contentView.addSubview(bgView)
//        bgView.addSubview(isSelectBtn)
        bgView.addSubview(timeLab)
        bgView.addSubview(titleLab)
        bgView.addSubview(icon)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalToSuperview()
            make.top.equalTo(10)
        }
//        isSelectBtn.snp.makeConstraints { make in
//            make.left.equalTo(15)
//            make.centerY.equalToSuperview()
//        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(timeLab)
            make.right.equalTo(-45)
            make.top.equalTo(40)
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
    }
    
//    @objc func btnClick(btn: UIButton) {
//        if let block = selectBlock {
//            block(btn.tag)
//        }
//    }
    
    var dataModel: NoticeModel? {
        didSet {
            timeLab.text = dataModel?.time
            titleLab.text = dataModel?.title
        }
    }
//    func setDataModel(dataModel: NoticeModel?, isSelect: Int) {
//        timeLab.text = dataModel?.time
//        titleLab.text = dataModel?.title
//        if isSelect == 1 {
//            isSelectBtn.isSelected = true
//        } else {
//            isSelectBtn.isSelected = false
//        }
//    }
//    func setBenefitDataModel(dataModel: BenefitInfoModel?, isSelect: Int) {
//        timeLab.text = dataModel?.start_time
//        titleLab.text = dataModel?.title
//        if isSelect == 1 {
//            isSelectBtn.isSelected = true
//        } else {
//            isSelectBtn.isSelected = false
//        }
//    }
}
class BenefitInfoCell: UITableViewCell {
    typealias SelectBtnClickdBlock = (_ id: Int) -> Void
    var selectBlock: SelectBtnClickdBlock?
    private lazy var bgView: UIView = {
        let aView = UIView()
        aView.backgroundColor = .white
        aView.layer.cornerRadius = 5
        aView.layer.masksToBounds = true
        return aView
    }()
    lazy var isSelectBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "unSelect_icon"), for: .normal)
        btn.setImage(UIImage.init(named: "select_icon"), for: .selected)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        return lab
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(14)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 2
        return lab
    }()
    
    lazy var icon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "arrow_right_list")
        img.contentMode = .center
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.init(hexString: "EDEEF3")
        contentView.addSubview(bgView)
        bgView.addSubview(isSelectBtn)
        bgView.addSubview(timeLab)
        bgView.addSubview(titleLab)
        bgView.addSubview(icon)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalToSuperview()
            make.bottom.equalTo(-10)
        }
        isSelectBtn.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.top.equalTo(20)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(timeLab)
            make.right.equalTo(-45)
            make.top.equalTo(40)
        }
        icon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func btnClick(btn: UIButton) {
        if let block = selectBlock {
            block(btn.tag)
        }
    }
    
    var dataModel: NoticeModel? {
        didSet {
            timeLab.text = dataModel?.time
            titleLab.text = dataModel?.title
        }
    }
    func setDataModel(dataModel: NoticeModel?, isSelect: Int) {
        timeLab.text = dataModel?.time
        titleLab.text = dataModel?.title
        if isSelect == 1 {
            isSelectBtn.isSelected = true
        } else {
            isSelectBtn.isSelected = false
        }
    }
    func setBenefitDataModel(dataModel: BenefitInfoModel?, isSelect: Int) {
        timeLab.text = dataModel?.start_time
        titleLab.text = dataModel?.title
        if isSelect == 1 {
            isSelectBtn.isSelected = true
        } else {
            isSelectBtn.isSelected = false
        }
    }
}
