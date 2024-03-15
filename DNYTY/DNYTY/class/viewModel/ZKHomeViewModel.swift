//
//  ZKHomeViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit
import RxRelay

class ZKHomeViewModel: ZKViewModel, ViewModelType {
    enum BannerLink {
        case url(url: URL)
        case game(url: URL)
        case discount(model: WLUserActiveListDataModel)
        case none
    }
    
    typealias Game = ZKHomeServer.Game
    struct Input {
        let viewWillShow: Observable<Void>
        let headerRefresh: Observable<Void>
        let gameTabSelect: Observable<Int>
        let aboutSelect: Observable<Int>
        let logoutTap: Observable<Void>
        let bannerTap: Observable<Int>
       
    }
    
    struct Output {
        let bannerImageUrls: Driver<[String]> //banner
        let communityIconURLs: Driver<[URL?]> //论坛图标列表
        let openUrl: Driver<URL>
        let showNotice: Driver<[WLNoticeAppDataModel]> //显示公告
        let scrollNotice: Driver<String>
        let money: Driver<String>
        let bannerLink: Driver<BannerLink>
    }

    let server = ZKHomeServer()
    
    let firtTabList: BehaviorRelay<[ZKHomeServer.Game]> = BehaviorRelay(value: [])
    //let firtSelectIndex: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    let selectFirtGame: BehaviorRelay<Game?> = BehaviorRelay(value: nil)
    let hotPageHotList: BehaviorRelay<[Game]> = BehaviorRelay(value: [])
    
    func transform(input: Input) -> Output {
        let server = self.server
        //let userServer = ZKUserServer()
        let walletServer = ZKWalletServer()
        let indicator = self.indicator
        let allRefresh = input.headerRefresh.merge(with: input.viewWillShow)
        //banner
        let banners = allRefresh.flatMap{ server.getBanner().trackActivity(self.headerLoading) }.share()
        let bannerImageUrlsOuntput = banners.map{ $0.map{ b in b.pic } }.asDriver(onErrorJustReturn: [])
        
        let bannerLink = input.bannerTap.withLatestFrom(banners) {
            $1[$0]
        }.flatMap { banner -> Observable<BannerLink> in
            switch banner.linkType {
            case 1:
                guard let url = URL(string: banner.link) else { return .just(.none) }
                return .just(.url(url: url))
            case 2:
                guard let id = Int(banner.link) else { return .just(.none) }
                return server.getActiveList().trackActivity(self.indicator).flatMap { groupList -> Observable<BannerLink> in
                    for list in groupList {
                        
                        if let model = list.first(where: { $0.id == id}) {
                            return .just(.discount(model: model))
                        }
                    }

                    return .just(.none)
                }
            case 4:
                let arg = banner.link.split(separator: ",")
                guard let idStr = arg.last, let id = Int(idStr) else { return .just(.none) }
                
                return server.getGameUrl(id: id).trackActivity(self.indicator).flatMap { resp -> Observable<BannerLink> in
                    if resp.isOK, let url = resp.data {
                        return .just(.game(url: url))
                    }
                    DefaultWireFrame.showPrompt(text: resp.message ?? "")
                    return .never()
                }
            default:
                return .just(.none)
            }
        }.asDriver(onErrorJustReturn: .none)
        
        
        
        //tab列表
        let firtList = input.headerRefresh.flatMap{
            //热门游戏和，tab列表
            Observable.combineLatest(server.getAllGame(), server.getMenu()) { hotList, firtTabList in
                [Game(name: "All Game", icon: RImage.all_game(), childrens: hotList)] + firtTabList
            }
        }.share()
        
        
        firtList.bind(to: self.firtTabList).disposed(by: rx.disposeBag)
        
        
        //tab选中
        let firtSelectIndex = firtList.filter{ $0.count != 0 }.map{ _ in 0 }.merge(with: input.gameTabSelect).share()
        //firtSelectIndex.bind(to: self.firtSelectIndex).disposed(by: rx.disposeBag)
        
        let selectFirtGame = firtSelectIndex.withLatestFrom(self.firtTabList) { index, gameList in
            gameList[index]
        }.share()
        selectFirtGame.bind(to: self.selectFirtGame).disposed(by: rx.disposeBag)
        
        
        //论坛
        let communityList = input.viewWillShow.flatMap{ server.communityList() }.share()
        let communityListOutput = communityList.map{ $0.map{ $0.iconURL } }.asDriver(onErrorJustReturn: [])
        
        let openAbountUrl = input.aboutSelect.withLatestFrom(communityList) {
            $1[$0]
        }.map{ $0.jumpURL }.unwrap()
        
        input.logoutTap.flatMapLatest {
            server.logout().trackActivity(indicator)
        }.bind { //退出成功
            ZKLoginUser.shared.clean()
            UIApplication.appDeltegate.presentInitialScreen()
        }.disposed(by: rx.disposeBag)
        let noticesList = walletServer.getNoticeList().share()
        
        let showNoticesOutput = noticesList.map{ notices -> [WLNoticeAppDataModel] in
            if ZKLoginUser.shared.isLogin {
                return notices.filter { $0.popup_type == 1 }
            }
            return notices.filter { $0.popup_type == 2 }
        }.filter{ !$0.isEmpty }.asDriver(onErrorJustReturn: [])
        
        let scrollNotices = input.headerRefresh.flatMap{ walletServer.getNoticeList().trackActivity(self.headerLoading) }.merge(with: noticesList).map{ list -> String in
            let textlist = list.filter{ $0.popup_type == 3 }.map { notice in
                notice.content ?? ""
            }
            return textlist.joined(separator: "                           ")
        }.asDriver(onErrorJustReturn: "")
        
        let wallet = Observable.just(ZKShareManager.shared.wallet.value)
            .merge(with:
                    input.viewWillShow
                    .filter{ _ in ZKLoginUser.shared.isLogin }
                    .flatMapLatest{ walletServer.getWallet() }
            ).unwrap()
        
        let money = wallet.map { wallet in
            (wallet.sumBalance/100).stringValue
        }.asDriver(onErrorJustReturn: "0")
        
        //let config = ZKShareManager.shared.config.unwrap().merge(with: userServer.startConfig().trackActivity(indicator) )
        
        //let openKefuUrl = input.kefuTap.withLatestFrom(config).map{ URL(string: $0.kefuUrl) }.unwrap()
        
        let openUrl = openAbountUrl.asDriverOnErrorJustComplete()
        
        input.viewWillShow.flatMapLatest{ server.getPageHotList() }.bind(to: hotPageHotList).disposed(by: rx.disposeBag)
        
        return Output(bannerImageUrls: bannerImageUrlsOuntput, communityIconURLs: communityListOutput, openUrl: openUrl, showNotice: showNoticesOutput, scrollNotice: scrollNotices, money: money, bannerLink: bannerLink)
    }
}
