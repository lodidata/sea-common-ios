//
//  WLRegisterPhoneCodeListView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/8.
//

import UIKit

class WLRegisterPhoneCodeListView: ZKView {
    
    struct PhoneCodeListItemModel {
        let icon: UIImage?
        let name: String
        let code: String
    }

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, PhoneCodeListItemModel>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhoneCodeListCell
        cell.img.image = item.icon
        cell.lab.text = item.name + "  +" + item.code
        return cell
    }
    
    let items: BehaviorRelay<[SectionModel<String, PhoneCodeListItemModel>]> = BehaviorRelay(value: [])
    
    let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(PhoneCodeListCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.init(hexString: "7F4FE8")?.cgColor
        layer.borderWidth = 2
        
        addSubview(tableView)
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class PhoneCodeListCell: UITableViewCell {
    let img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    let lab: UILabel = {
        let lab = UILabel.init()
        lab.textColor = UIColor.init(hexString: "D6D6D6")
        lab.font = kSystemFont(14)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(img)
        contentView.addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalToSuperview()
        }
        lab.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
    }
}
