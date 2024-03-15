//
//  ZKHomeGameSearchViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/8
//  
//
    

import UIKit
import RxRelay
import RxCocoa

class ZKHomeGameSearchViewModel: ZKViewModel, ViewModelType {
    typealias Game = ZKHomeServer.Game
    
    struct Input {
        let secondTabSelectIndex: Observable<Int> //二级菜单选择
        let searchGameText: Observable<String> //搜索游戏
        let tapGameIndex: Observable<Int>
    }
    
    struct Output {
        let twoTopGameImageUrls: Driver<[SectionModel<String, URL?>]> //二级游戏菜单
        let gameList: Driver<[AnimatableSectionModel<String, Game>]> //三级游戏菜单
        let clearSearch: Driver<Void> //清除搜索
        let enterGame: Driver<ZKServerResult<URL>>
        let moreBtnHidden: Driver<Bool>
    }
    
    let server = ZKHomeServer()
    
    let firtTabSelectGame: Observable<Game?>
    let secondSelectIndex: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    let secondTabList: BehaviorRelay<[Game]> = BehaviorRelay(value: [])
    
    init(firtTabSelectGame: Observable<Game?>) {
        self.firtTabSelectGame = firtTabSelectGame
    }
    
    func transform(input: Input) -> Output {
        let server = self.server
        
        firtTabSelectGame.map{ game in
            game?.childrens ?? []
        }.bind(to: self.secondTabList).disposed(by: rx.disposeBag)
        
        //二级菜单显示
        let twoTopGameImageUrls = secondTabList.map{ [SectionModel(model: "", items: $0.map{ $0.imgURL})] }.asDriver(onErrorJustReturn: [])
        
        //默认二级选择+用户二级选择  (index)
        let secondSelectIndex = secondTabList.filter{ $0.count != 0 }.map{ _ in 0 }.merge(with: input.secondTabSelectIndex)
        secondSelectIndex.bind(to: self.secondSelectIndex).disposed(by: rx.disposeBag)
        
        let currentSelectSecondGame = secondSelectIndex.withLatestFrom(secondTabList){ $1[$0] }
        
        
        //游戏
        let gameList = currentSelectSecondGame.flatMap{ game -> Observable<[Game]> in
            if game.isHot { //如果是热门游戏直接返回
                return .just(game.childrens)
            }
            return server.getMenu(id: game.id).trackActivity(self.indicator)
        }.share(replay: 1)
        
        

        
        
        // 搜索
        // 清空搜索显示全部
        let showAllGames = input.searchGameText.filter{ $0.isEmpty }.withLatestFrom(gameList)
        
        // 有搜索
         //当前选择的二级
        
        let searchGames = input.searchGameText.debounce(.seconds(1), scheduler: MainScheduler.instance).filter{ !$0.isEmpty }.flatMapLatest { searchText in
            server.searchGame(name: searchText)
        }
        
        let allGameList = Observable.of(gameList, showAllGames, searchGames).merge().share()
        let gameListOutput = allGameList.map{ Array($0.prefix(15)) }.map{ [AnimatableSectionModel(model: "", items: $0)] }.asDriver(onErrorJustReturn: [])
        
        let clearSearch = secondTabList.mapToVoid().merge(with: secondSelectIndex.mapToVoid()).asDriverOnErrorJustComplete()
        
        let enterGame = input.tapGameIndex.withLatestFrom(allGameList) { $1[$0].url }.flatMapLatest{
            server.getGameUrl(url: $0).trackActivity(self.indicator)
        }.asDriverOnErrorJustComplete()
        
        let moreBtnHidden = allGameList.map{ $0.count <= 15 }.asDriver(onErrorJustReturn: true)
        
        return Output(twoTopGameImageUrls: twoTopGameImageUrls, gameList: gameListOutput, clearSearch: clearSearch, enterGame: enterGame, moreBtnHidden: moreBtnHidden)
    }
}
