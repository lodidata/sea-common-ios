//
//  WLVIPRecordController.swift
//  DNYTY
//
//  Created by wulin on 2022/6/21.
//

import UIKit
import PagingViewKit

class WLVIPRecordController: ZKViewController {

    var pagingTitleView: PagingTitleView?
    var pagingContentView: PagingContentScrollView?
    private lazy var navView: WLWithdrawNav2View = {
        let aView = WLWithdrawNav2View.init()
        aView.titleLab.text = "vip0".wlLocalized
        return aView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navView.rightBtn.setImage(UIImage.init(named: "search_black"), for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func initSubView() {
        super.initSubView()
        view.addSubview(navView)
        
        let configure = PagingTitleViewConfigure.init()
        configure.showBottomSeparator = false
        configure.indicatorColor = RGB(127, 79, 232)
        configure.selectedColor = RGB(127, 79, 232)
        configure.selectedFont = kSystemFont(14)
        //configure.indicatorFixedWidth = 30
        configure.color = RGB(114, 120, 139)
        
        
        
        let integralHistory = WLIntegralHistoryController() //积分历程
        integralHistory.rightBtn = navView.rightBtn
        let improveProcess = WLImproveProcessController() //晋级升降
        improveProcess.rightBtn = navView.rightBtn
        let receiveRecord = WLReceiveRecordController() //领取记录
        receiveRecord.rightBtn = navView.rightBtn

        pagingTitleView = PagingTitleView.init(frame: CGRect.init(x: 0, y: 64, width: kScreenWidth, height: 44), titles: ["vip13".wlLocalized,"vip14".wlLocalized,"vip15".wlLocalized], delegate: self, configure: configure)
        pagingTitleView?.backgroundColor = .white
        pagingContentView = PagingContentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 110), parentVC: self, childVCs: [integralHistory,improveProcess,receiveRecord])
        pagingContentView?.delegate = self
        
        view.addSubview(pagingTitleView!)
        view.addSubview(pagingContentView!)
        
    }
    
    override func layoutSubView() {
        super.layoutSubView()
        navView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(NAV_HEIGHT)
        }
        pagingTitleView?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(navView.snp.bottom)
            make.height.equalTo(44)
        })
        pagingContentView?.snp.makeConstraints({ make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(pagingTitleView!.snp.bottom)
            make.bottom.equalTo(0)
        })

    }
    
    override func bindViewModel() {
        super.bindViewModel()
        navView.backBtn.rx.tap.bind { [unowned self] _ in
            self.navigationController?.popViewController()
        }.disposed(by: rx.disposeBag)
        
    }
    
}
extension WLVIPRecordController: PagingTitleViewDelegate, PagingContentScrollViewDelegate {
    func pagingTitleView(pagingTitleView: PagingTitleView, index: Int) {
        pagingContentView?.setPagingContentScrollView(index: index)
    }
    func pagingContentScrollView(pagingContentScrollView: PagingContentScrollView, progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        pagingTitleView?.setPagingTitleView(progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
        
    }
}
