//
//  ZKHelpCenterViewController.swift
//  DNYTY
//
//  Created by WL on 2022/7/5
//  
//
    

import UIKit

class ZKHelpCenterViewController: ZKViewController {
    
    let items: [(icon: UIImage?, title: String?)] = [
        (RImage.help_deposit(), "help0".wlLocalized),
        (RImage.help_withdraw(), "help1".wlLocalized),
        (RImage.help_cj(), "help2".wlLocalized),
        (RImage.help_xy(), "help3".wlLocalized),
        (RImage.help_ys(), "help4".wlLocalized),
        (RImage.help_other(), "help5".wlLocalized)
    ]
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.register(ZKHelpCenterCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 62
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "account15".wlLocalized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func initSubView() {
        view.addSubview(tableView)
    }
    
    override func layoutSubView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }

    override func bindViewModel() {
        Observable.just(items).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ZKHelpCenterCell.self)){ _, item, cell in
            cell.icon.image = item.icon
            cell.titleLab.text = item.title
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected.bind { [weak self] indexPath in
            guard let self = self else { return  }
            switch indexPath.row {
            case 0:
                self.navigator.show(segue: .h5(page: .helpDeposits), sender: self)
            case 1:
                self.navigator.show(segue: .h5(page: .helpWithdrawals), sender: self)
            case 2:
                self.navigator.show(segue: .h5(page: .helpFAQs), sender: self)
            case 3:
                self.navigator.show(segue: .h5(page: .helpUserPolicy), sender: self)
            case 4:
                self.navigator.show(segue: .h5(page: .helpPrivacyPolicy), sender: self)
            case 5:
                self.navigator.show(segue: .h5(page: .helpOther), sender: self)
            default:
                break
            }
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


class ZKHelpCenterCell: UITableViewCell {
    let icon: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    let showIcon: UIImageView = {
        let imgV = UIImageView(image:RImage.table_more_w())
        return imgV
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor(hexString: "#30333A")
        lab.font = kMediumFont(14)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(icon)
        contentView.addSubview(titleLab)
        contentView.addSubview(showIcon)
        
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#E8E9F0")
        contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(13)
            make.centerY.equalToSuperview()
        }
        showIcon.snp.makeConstraints { make in
            make.right.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
