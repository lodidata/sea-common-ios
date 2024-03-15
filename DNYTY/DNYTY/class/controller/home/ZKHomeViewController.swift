//
//  ZKHomeViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/6
//  
//
    

import UIKit
import SDCycleScrollView
import LiveChat
import FSPagerView


class ZKHomeViewController: ZKScrollViewController, CircleMenuDelegate {
    
    
    //顶部
    let naviView = ZKHomeNaviView()
    
//    let closeMenuBtn: UIButton = {
//        let btn = UIButton(type: .custom)
//        btn.setBackgroundImage(RImage.close_btn2(), for: .normal)
//        return btn
//    }()
    
//    let gameMenuBtn: CircleMenu = {
//        let menu = CircleMenu(frame: CGRect(x: 0, y: 0, width: 62, height: 62), normalIcon: nil, selectedIcon: nil, buttonsCount: 5)
//        menu.showDelay = 0.1
//        menu.subButtonsRadius = 25
//        menu.distance = 90
//        if let path = Bundle.main.path(forResource: "mini-game-logo", ofType: "gif") {
//            menu.sd_setImage(with: URL(fileURLWithPath: path), for: .normal)
//            menu.sd_setImage(with: URL(fileURLWithPath: path), for: .selected)
//        }
//
//        return menu
//    }()
    
    let scrollNoticesView = ZKScrollNoticesView()
    //banner
    let bannerView: FSPagerView = {
       let bannerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * amount375(155)))
        bannerView.automaticSlidingInterval = 3
        bannerView.backgroundColor = .black
        bannerView.isInfinite = true
        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "bannerCell")
        return bannerView
    }()
    //游戏分类
    let gameTabMenu = ZKHomeGameTabView()
    //游戏
    let searchGameVC: ZKHomeGameSearchViewController
    //语言
    let languageBtn = ZKHomeLanguageButton()
    
    let bottomHelpItemsView = ZKHomeBottomItemsView()
    
    let helpTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.separatorStyle = .none
        tableView.rowHeight = 46
        tableView.register(ZKHomeHelpCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let languageView = ZKHomeLanguageTableView()
    
    let aboutView = ZKHomeBottomAboutView()
    
    let kefuBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isHidden = true
        btn.setBackgroundImage(RImage.kefu(), for: .normal)
        return btn
    }()
    
    let zhuangpanBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(RImage.zhuangpan(), for: .normal)
        return btn
    }()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, UIImage?>> { _, collectionView, indexPath, image in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ZKImageCollectionCell
        cell.imageView.image = image
        return cell
    } configureSupplementaryView: { ds, collectionView, _, indexPath in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! ZKHomeLogoHeader
        header.titleLab.text = ds[indexPath.section].model
        return header
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(ZKImageCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ZKHomeLogoHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collectionView
    }()
    
    init(viewModel: ZKHomeViewModel) {
        let searchGameViewModel = ZKHomeGameSearchViewModel(firtTabSelectGame: viewModel.selectFirtGame.asObservable())
        self.searchGameVC = ZKHomeGameSearchViewController(viewModel: searchGameViewModel)
        
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
        //scrollNoticesView.scrollLab.setAnimate()
    }
    
    
    override func initSubView() {
        super.initSubView()
        scrollView.backgroundColor = UIColor(hexString: "#171633")
        view.backgroundColor = .black
        
        scrollView.mj_header = MJRefreshNormalHeader()
        
        view.addSubview(naviView)
        contentView.addSubview(bannerView)
        contentView.addSubview(scrollNoticesView)
        contentView.addSubview(gameTabMenu)
        self.addChild(searchGameVC)
        contentView.addSubview(searchGameVC.view)
        searchGameVC.didMove(toParent: self)
        
        
        
        
        contentView.addSubview(languageBtn)
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        
        contentView.addSubview(bottomHelpItemsView)
        
        
        
        contentView.addSubview(helpTableView)
        contentView.addSubview(aboutView)
        
        scrollView.addSubview(languageView)

//        view.addSubview(gameMenuBtn)
//        gameMenuBtn.delegate = self
//        gameMenuBtn.addSubview(closeMenuBtn)
//
        
        view.addSubview(kefuBtn)
        view.addSubview(zhuangpanBtn)
    }
    
    
    override func layoutSubView() {
        naviView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(naviView.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        
        scrollNoticesView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(bannerView.snp.top)
            make.height.equalTo(30)
        }
        
        bannerView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(bannerView.snp.width).multipliedBy(amount375(155))
        }
        
        gameTabMenu.snp.makeConstraints { make in
            make.left.right.equalTo(naviView)
            make.top.equalTo(bannerView.snp.bottom)
            make.height.equalTo(gameTabMenu.snp.width).multipliedBy(amount375(93))
        }
        
        searchGameVC.view.snp.makeConstraints { make in
            make.left.right.equalTo(naviView)
            make.top.equalTo(gameTabMenu.snp.bottom)
        }
        
        languageBtn.snp.makeConstraints { make in
            make.top.equalTo(searchGameVC.view.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        let line1 = UIView()
        line1.backgroundColor = UIColor(hexString: "#25244A")
        contentView.addSubview(line1)
        line1.snp.makeConstraints { make in
            make.top.equalTo(languageBtn.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)

        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(line1.snp.bottom)
            make.height.equalTo(0)
        }


        collectionView.rx.observe(CGSize.self, "contentSize").bind { [weak self] contentSize in
            guard let self = self, let contentSize = contentSize else { return  }
            self.collectionView.snp.updateConstraints { make in
                make.left.equalTo(18)
                make.right.equalTo(-18)
                make.top.equalTo(line1.snp.bottom)
                make.height.equalTo(contentSize.height)
    
            }
        }.disposed(by: rx.disposeBag)
        
        let line2 = UIView()
        line2.backgroundColor = UIColor(hexString: "#25244A")
        contentView.addSubview(line2)
        line2.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)

        }
        
        
        bottomHelpItemsView.snp.makeConstraints { make in
            make.left.right.equalTo(naviView)
            make.top.equalTo(line2.snp.bottom)
            make.height.equalTo(78)
        }
        
        let line3 = UIView()
        line3.backgroundColor = UIColor(hexString: "#25244A")
        contentView.addSubview(line3)
        line3.snp.makeConstraints { make in
            make.top.equalTo(bottomHelpItemsView.snp.bottom)
            make.left.right.equalTo(naviView)
            make.width.equalToSuperview().offset(-20)
            make.height.equalTo(1)
        }
        
//        helpTableView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(0)
//        }
        
        helpTableView.rx.observe(CGSize.self, "contentSize").bind { [weak self] contentSize in
            guard let contentSize = contentSize, let self = self else {
                return
            }
            
            self.helpTableView.snp.remakeConstraints { make in
                make.top.equalTo(line3.snp.bottom)
                make.left.right.equalTo(self.naviView)
                make.height.equalTo(contentSize.height)
            }
        }.disposed(by: rx.disposeBag)
        
        aboutView.snp.makeConstraints { make in
            make.top.equalTo(self.helpTableView.snp.bottom)
            make.left.right.equalTo(self.naviView)
            make.height.equalTo(90)
            make.bottom.equalToSuperview()
        }
        
        languageView.snp.makeConstraints { make in
            make.width.equalTo(125)
            make.top.equalTo(languageBtn.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        
//        gameMenuBtn.snp.makeConstraints { make in
//            make.right.equalTo(-20)
//            make.bottom.equalTo(view.snp.centerY).offset(-60)
//            make.size.equalTo(CGSize(width: 62, height: 62))
//        }
//
//        closeMenuBtn.snp.makeConstraints { make in
//            make.top.equalTo(gameMenuBtn).offset(-5)
//            make.right.equalTo(gameMenuBtn).offset(5)
//        }
        
        kefuBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.right.equalTo(-25)
        }
        
        zhuangpanBtn.snp.makeConstraints { make in
            make.right.equalTo(kefuBtn)
            make.bottom.equalTo(kefuBtn.snp.top).offset(-15)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        //隐藏热门游戏按钮
//        closeMenuBtn.rx.tap.bind { [weak self] in
//            guard let self = self else {
//                return
//            }
//
//            self.gameMenuBtn.isHidden = true
//
//
//        }.disposed(by: rx.disposeBag)
        
        //是否登录
        Observable.just(ZKLoginUser.shared.isLogin).bind(to: naviView.rx.isLogin).disposed(by: rx.disposeBag)
        zhuangpanBtn.isHidden = !ZKLoginUser.shared.isLogin
        
//        Observable.just([SectionModel(model: "", items: [RImage.slot(), RImage.slot(), RImage.slot(), RImage.slot(), RImage.slot()])]).bind(to: gameTabMenu.collectionView.rx.items(dataSource: gameTabMenu.dataSource)).disposed(by: rx.disposeBag)
        
        //登录登出
        naviView.logoutButtonView.loginBtn.rx.tap.bind { _ in
            Navigator.default.show(segue: .login, sender: self)
        }.disposed(by: rx.disposeBag)
        naviView.logoutButtonView.registerBtn.rx.tap.bind { _ in
            Navigator.default.show(segue: .register, sender: self)
        }.disposed(by: rx.disposeBag)
        
        //语言
        languageBtn.logo.image = WLLanguageManager.shared.currentLanguageDisplayImage?.byResize(to: CGSize(width: 25, height: 25))
        languageBtn.titleLab.text = WLLanguageManager.shared.currentLanguageDisplayName
        languageBtn.rx.tap().map{ !self.languageView.isHidden }.bind(to: languageView.rx.isHidden).disposed(by: rx.disposeBag)
        languageView.rx.didSelect.bind { lang in
            WLLanguageManager.shared.currentLanguage = lang
            UIApplication.appDeltegate.presentInitialScreen()
        }.disposed(by: rx.disposeBag)
        
        //转盘按钮
        zhuangpanBtn.rx.tap.bind { [unowned self] _ in
            luckyRequest()
        }.disposed(by: rx.disposeBag)
        
        //中部logo配置
        Observable.just([
            SectionModel(model: "Game Provider", items: [RImage.logo_s1_1(), RImage.logo_s1_2(), RImage.logo_s1_3(), RImage.logo_s1_4(), RImage.logo_s1_5(), RImage.logo_s1_6(), RImage.logo_s1_7(), RImage.logo_s1_8(), RImage.logo_s1_9(), RImage.logo_s1_10(), RImage.logo_s1_11()]),
            SectionModel(model: "Payment Gateway Affiliate", items: [RImage.logo_s2_1(), RImage.logo_s2_2(), RImage.logo_s2_3(), RImage.logo_s2_4(), RImage.logo_s2_5()]),
            SectionModel(model: "Certified Institute", items: [RImage.logo_s3_1(), RImage.logo_s3_2()])
        ]).bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        
        //
        let bottomItems = [(RImage.home_zf(), "home4".wlLocalized), (RImage.home_qtzc(), "home5".wlLocalized), (RImage.home_yd(), "home6".wlLocalized), (RImage.home_pl(), "home7".wlLocalized), (RImage.home_dbz(), "home13".wlLocalized)]
        bottomHelpItemsView.items = bottomItems
        
        //底部列表
        let helpDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ZKHomeHelpCell
            cell.titlelab.text = item
            return cell
        }
        //, "统计数字"
        let helpList = ["home8".wlLocalized, "home9".wlLocalized, "home10".wlLocalized, "home11".wlLocalized]
        Observable.just([SectionModel(model: "", items: helpList)]).bind(to: helpTableView.rx.items(dataSource: helpDataSource)).disposed(by: rx.disposeBag)
        
        helpTableView.rx.itemSelected.bind { [weak self] indexPath in
            guard let self = self else { return  }
            switch indexPath.row {
            case 0:
                self.navigator.show(segue: .h5(page: .about), sender: self)
            case 1:
                self.navigator.show(segue: .h5(page: .help), sender: self)
            case 2:
                self.navigator.show(segue: .h5(page: .rlues), sender: self)
            case 3:
                self.navigator.show(segue: .h5(page: .gameRlues), sender: self)
                
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
        
        
        guard let viewModel = viewModel as? ZKHomeViewModel else {
            return
        }
        
        let input = ZKHomeViewModel.Input(viewWillShow: rx.viewWillAppear.mapToVoid(),
                                          headerRefresh: scrollView.mj_header!.rx.refreshing.startWith(()).share(),
                                          gameTabSelect: gameTabMenu.collectionView.rx.itemSelected.map{ $0.item },
                                          aboutSelect: aboutView.rightSelectIndex.asObservable(),
                                          logoutTap: naviView.loginButtonView.logoutBtn.rx.tap.asObservable(),
                                          bannerTap: bannerView.rx.itemSelected.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        //banner
        output.bannerImageUrls.drive(bannerView.rx.items(cellIdentifier: "bannerCell")) { _, item, cell in
            cell.imageView?.sd_setImage(with: URL(string: item), completed: nil)
        }.disposed(by: rx.disposeBag)
        //banner点击
        output.bannerLink.drive {[weak self] linkType in
            guard let self = self else { return  }
            switch linkType {
            case .game(let url):
                self.navigator.show(segue: .webView(url: url), sender: self, transition: .modal)
            case .url(let url):
                self.navigator.show(segue: .webView(url: url), sender: self, transition: .modal)
            case .discount(let model):
                self.navigator.show(segue: .discountDetail(model: model), sender: self)
                break
            default:
                break
            }
        }.disposed(by: rx.disposeBag)
        
        
        //一级游戏菜单
        viewModel.firtTabList.bind(to: gameTabMenu.collectionView.rx.items(cellIdentifier: "cell", cellType: ZKHomeGameTabCell.self)){ index, game, cell in
            if index == 0 {
                cell.icon.image = game.image
            } else {
                cell.icon.sd_setImage(with: game.imgURL)
            }
            cell.titleLab.text = game.name
        }.disposed(by: rx.disposeBag)
        
        viewModel.firtTabList.bind { [weak self] gameList in
            guard let self = self, gameList.count != 0 else { return  }
            self.gameTabMenu.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        }.disposed(by: rx.disposeBag)
        
        
        //底部论坛
        output.communityIconURLs.drive(aboutView.rx.rightIconUrls).disposed(by: rx.disposeBag)
        //滚动公告
        output.scrollNotice.drive(scrollNoticesView.rx.text).disposed(by: rx.disposeBag)
        output.openUrl.drive{ [weak self] url in
            guard let self = self else { return  }
            self.navigator.show(segue: .webView(url: url), sender: self, transition: .modal)
        }.disposed(by: rx.disposeBag)
        
        
        //弹出公告
        output.showNotice.drive { [weak self] noteces in
            guard let self = self else {
                return
            }
            self.navigator.show(segue: .notifiList(list: noteces), sender: self, transition: .modal)
        }.disposed(by: rx.disposeBag)
        
        output.money.drive(naviView.loginButtonView.moneyLab.rx.text).disposed(by: rx.disposeBag)
        
        //游戏列表-更多热门游戏
        searchGameVC.hotBtn.rx.tap.bind { [weak self] in
            guard let self = self,let firtSelect = self.gameTabMenu.collectionView.indexPathsForSelectedItems?[0].item, let secondSelect = self.searchGameVC.twoGameList.tableView.indexPathForSelectedRow?.row
            else { return }
            
    
            let viewModel = ZKHotGameViewModel(firtTabList: viewModel.firtTabList.value,
                                               firtSelectIndex: firtSelect,
                                               secondSelectIndex: secondSelect)
            self.navigator.show(segue: .hotGame(viewModel:viewModel), sender: self)
        }.disposed(by: rx.disposeBag)


        viewModel.indicator.asObservable().bind(to: rx.loading).disposed(by: rx.disposeBag)
        viewModel.headerLoading.map{ !$0 }.asDriver().drive(scrollView.mj_header!.rx.endRefreshing).disposed(by: rx.disposeBag)
        
//        viewModel.hotPageHotList.bind { [weak self] list in
//            guard let self = self else { return  }
//            self.gameMenuBtn.buttonsCount = list.count
//        }.disposed(by: rx.disposeBag)
        
    }
    
//    func circleMenu(_ menu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
//        guard let viewModel = viewModel as? ZKHomeViewModel else {
//            return
//        }
//        let game = viewModel.hotPageHotList.value[atIndex]
//        button.sd_setBackgroundImage(with: game.imgURL, for: .normal, placeholderImage: kGamePlaceholderImage)
//        button.layer.cornerRadius = 25
//        button.layer.masksToBounds = true
//        button.layer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
//        button.layer.shadowOffset = CGSize(width: 0, height: 1)
//        button.layer.shadowRadius = 25
//        button.layer.shadowOpacity = 0.8
//    }
    

//    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
//        if !ZKLoginUser.shared.isLogin {
//            self.navigator.show(segue: .login, sender: self)
//            return
//        }
//
//
//        guard let viewModel = viewModel as? ZKHomeViewModel else {
//            return
//        }
//        let game = viewModel.hotPageHotList.value[atIndex]
//        let server = viewModel.server
//        server.getGameUrl(url: game.url).trackActivity(viewModel.indicator).bind { [weak self] result in
//            guard let self = self, let url = result.data else { return  }
//
//            self.navigator.show(segue: .webView(url: url), sender: self, transition: .modal)
//
//        }.disposed(by: rx.disposeBag)
//    }
//
//    func menuOpened(_ circleMenu: CircleMenu) {
//        gameMenuBtn.snp.remakeConstraints { make in
//            make.right.equalTo(-70)
//            make.bottom.equalTo(view.snp.centerY).offset(-60)
//            make.size.equalTo(CGSize(width: 62, height: 62))
//        }
//    }
//
//    func menuDidCollapsed(_ circleMenu: CircleMenu) {
//        gameMenuBtn.snp.remakeConstraints { make in
//            make.right.equalTo(-20)
//            make.bottom.equalTo(view.snp.centerY).offset(-60)
//            make.size.equalTo(CGSize(width: 62, height: 62))
//        }
//
//        UIView.animate(withDuration: 0.1) {
//            self.view.layoutIfNeeded()
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ZKHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = (collectionView.width - 3 * 31 - 40) / 4
            return CGSize(width: width, height: width * 28.0/50)
        } else if indexPath.section == 1 {
            let width = (collectionView.width - 4 * 22) / 5
            return CGSize(width: width, height: width * 28.0/50)
        }
    
        return CGSize(width: 112, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 40)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 22
        }
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: kScreenWidth, height: 60)
    }
}


extension ZKHomeViewController {
    //幸运轮盘-点击抽奖-get-获取相关信息.看活动是否存在
    func luckyRequest() {
        WLProvider.request(.wlGetActiveLucky) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                if let baseModel = WLBaseModel(JSON: json.dictionaryObject ?? [:]) {
                    if baseModel.state == 0 { //说明活动存在
                        Navigator.default.show(segue: .zhuanpan, sender: self)
                    } else {
                        self.showHUDMessage(baseModel.message)
                    }
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}


class ZKHomeHelpCell: UITableViewCell {
    let titlelab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = kSystemFont(12)
        
        return lab
    }()
    
    let icon: UIImageView = {
        let imgV = UIImageView(image:RImage.table_more_w())
        
        return imgV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hexString: "#171633")
        selectionStyle = .none
        
        contentView.addSubview(titlelab)
        contentView.addSubview(icon)
        
        let line = UIView()
        line.backgroundColor = UIColor(hexString: "#25244A")
        contentView.addSubview(line)
        
        titlelab.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.right.equalTo(-18)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
