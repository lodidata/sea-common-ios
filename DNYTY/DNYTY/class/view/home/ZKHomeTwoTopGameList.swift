//
//  ZKHomeLogoList.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit
import RxRelay

class ZKHomeTwoTopGameList: ZKView {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, URL?>> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKHomeTwoTopGameCell
        cell.imageV.sd_setImage(with: item)
        return cell
    }
    
    let items: PublishRelay<[SectionModel<String, URL?>]> = PublishRelay()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.rowHeight = 45
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexString: "#0E0D20")
        tableView.setContentHuggingPriority(.defaultLow, for: .vertical)
        //tableView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return tableView
    }()
    
    override func makeUI() {
        backgroundColor = UIColor(hexString: "#0E0D20")
        addSubview(tableView)
        
        self.tableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        
        
        
        
        
        tableView.register(ZKHomeTwoTopGameCell.self, forCellReuseIdentifier: "cell")
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        items.filter{ $0.count != 0 && $0[0].items.count != 0 }.bind { [weak self] _ in
            self?.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        }.disposed(by: rx.disposeBag)
    }
    
    override func bindViewModel() {
//        Observable.just([SectionModel(model: "", items: [RImage.logo1(), RImage.logo2(), RImage.logo3(), RImage.logo4(), RImage.logo5(), RImage.logo6(), RImage.logo7(), RImage.logo8(), RImage.logo9()])]).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class ZKHomeTwoTopGameCell: UITableViewCell {
    let imageV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hexString: "#0E0D20")
        //selectionStyle = .none
        
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let selectImageBackground = UIImageView(image: RImage.home_btn_select2())
        selectedBackgroundView = selectImageBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
