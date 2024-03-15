//
//  WLNoticeDetailController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/22.
//

import UIKit

class WLNoticeDetailController: WLViewController {

    var dataModel: NoticeModel?
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.text = dataModel?.time
        return lab
    }()
    private lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(18)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 0
        lab.text = dataModel?.title
        return lab
    }()
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "D6D9E3")
        return line
    }()
    private lazy var detailLab: UILabel = {
        let lab = UILabel()
        lab.font = kSystemFont(12)
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.numberOfLines = 0
        lab.text = dataModel?.content
        return lab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.titleLab.text = "accountDiscount1".wlLocalized
        navView.rightBtn.isHidden = true
        navView.rightBtn.setImage(UIImage.init(named: "delete_icon"), for: .normal)
        
    }
    
    override func initSubView() {
        super.initSubView()
        view.addSubview(scrollView)
        scrollView.addSubview(timeLab)
        scrollView.addSubview(titleLab)
        scrollView.addSubview(line)
        scrollView.addSubview(detailLab)
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.width.equalTo(kScreenWidth)
        }
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(20)
            make.right.equalTo(-15)
            make.width.equalTo(kScreenWidth - 30)
        }
        let titleLabHeight = dataModel?.title.heightWithText(18, 30)
        titleLab.snp.makeConstraints { make in
            make.left.right.equalTo(timeLab)
            make.top.equalTo(timeLab.snp.bottom).offset(10)
            if let height = titleLabHeight {
                make.height.equalTo(height)
            }
            
        }
        line.snp.makeConstraints { make in
            make.left.right.equalTo(timeLab)
            make.top.equalTo(titleLab.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        let detailLabHeight = dataModel?.content.heightWithText(12, 30)
        detailLab.snp.makeConstraints { make in
            make.left.right.equalTo(timeLab)
            make.top.equalTo(line.snp.bottom).offset(15)
            if let height = detailLabHeight {
                make.height.equalTo(height)
            }
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navView.rightBtn.rx.tap
            .bind { [unowned self] _ in
                deleteRequest(id: "\(dataModel?.id ?? 0)")
            }.disposed(by: rx.disposeBag)
    }
    

}

extension WLNoticeDetailController {
    func deleteRequest(id: String) {
        WLProvider.request(.deleteMessage(ids: id)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 {
                        self.showHUDMessage("new12".wlLocalized)
                        self.navigationController?.popViewController()
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
