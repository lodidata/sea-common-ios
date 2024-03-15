//
//  ZKHomeLanguageTableView.swift
//  DNYTY
//
//  Created by WL on 2022/6/9
//  
//
    

import UIKit

class ZKHomeLanguageTableView: ZKView {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKHomeLanguageTableCell
        cell.icon.image = WLLanguageManager.shared.displayImage(language: item)
        cell.titleLab.text = WLLanguageManager.shared.displayName(language: item)
        return cell
    }

    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func makeUI() {
        isHidden = true
        backgroundColor = .black
        layer.borderColor = UIColor(hexString: "#7F4FE8")?.cgColor
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.masksToBounds = true
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(ZKHomeLanguageTableCell.self, forCellReuseIdentifier: "cell")
        
        Observable.just([SectionModel(model: "", items: WLLanguageManager.availableLanguages)]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected.bind { [weak self] _ in
            guard let self = self else { return  }
            self.isHidden = false
        }.disposed(by: rx.disposeBag)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension Reactive where Base: ZKHomeLanguageTableView {
    var didSelect: ControlEvent<String> {
        base.tableView.rx.modelSelected(String.self)
    }
}

class ZKHomeLanguageTableCell: UITableViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .black
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 2
        lab.textColor = .white
        lab.font = kSystemFont(14)
        lab.text = "    "
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .black
        
        contentView.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.left.equalTo(icon.snp.right).offset(10)
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
