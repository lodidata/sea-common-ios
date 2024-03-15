//
//  ZKHotGameViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/10
//  
//
    

import UIKit
import RxRelay

class ZKHotGameViewModel: ZKViewModel, ViewModelType {

    typealias Game = ZKHomeServer.Game
    struct Input {
        let viewWillShow: Observable<Void>
        let headerRefresh: Observable<Void>
        let firtTabSelect: Observable<Int>
        let secondTabSelect: Observable<Int>
        let searchGameText: Observable<String> //搜索游戏
        let tapGameIndex: Observable<Int>
    }
    
    struct Output {
        
        let secondTabList: Driver<[SectionModel<String, ZKHomeServer.Game>]> //tab列表
        let gameImageUrls: Driver<[SectionModel<String, URL?>]> //三级游戏菜单
        let clearSearch: Driver<Void> //清除搜索
        let enterGame: Driver<ZKServerResult<URL>>
    }
    
    let server = ZKHomeServer()
    
    var firtTabList: BehaviorRelay<[ZKHomeServer.Game]>//一级tab列表
    var secondTabList: BehaviorRelay<[ZKHomeServer.Game]>
    var firtSelectIndex: BehaviorRelay<Int>
    var secondSelectIndex: BehaviorRelay<Int?>
    init(firtTabList: [ZKHomeServer.Game],
         firtSelectIndex: Int,
         secondSelectIndex: Int) {
        self.firtTabList = BehaviorRelay(value: firtTabList)
        self.secondTabList = BehaviorRelay(value: firtTabList[firtSelectIndex].childrens)
        self.firtSelectIndex = BehaviorRelay(value: firtSelectIndex)
        self.secondSelectIndex = BehaviorRelay(value: secondSelectIndex)
    }
    
    func transform(input: Input) -> Output {
        let server = self.server
  
        
        input.secondTabSelect.bind(to: secondSelectIndex).disposed(by: rx.disposeBag)
        
        
        
        //选择一级列表
        input.firtTabSelect.bind(to: firtSelectIndex).disposed(by: rx.disposeBag)
        //二级列表
        let secondTabGameList = input.firtTabSelect.withLatestFrom(firtTabList){
            $1[$0].childrens
        }.share()
        secondTabGameList.bind(to: secondTabList).disposed(by: rx.disposeBag)
        //二级列表默认选择(默认第一个)
        let secondSelectIndex = secondTabGameList.map{ $0.count == 0 ? nil : 0 }.share()
        secondSelectIndex.bind(to: self.secondSelectIndex).disposed(by: rx.disposeBag)
        
        let secondTabListOutput = secondTabList.map{ [SectionModel(model: "", items: $0)] }.asDriver(onErrorJustReturn: [])
        
        
        //游戏三级列表
        let currentSelectGame = self.secondSelectIndex.withLatestFrom(secondTabList) { index, secondTabGameList -> Game? in
            return index == nil ? nil : secondTabGameList[index!]
        }
        
        
        
        let gameList = currentSelectGame.flatMap{ game -> Observable<[Game]> in
            guard let game = game else { return .just([]) }
            
            if game.isHot { //如果是热门游戏直接返回
                return .just(game.childrens)
            }
            return self.server.getMenu(id: game.id).trackActivity(self.indicator)
        }.share(replay: 1)
      
        
        // 搜索
        // 清空搜索显示全部
        let showAllGames = input.searchGameText.filter{ $0.isEmpty }.withLatestFrom(gameList)
        
        // 有搜索
         //当前选择的二级
        let searchGames = input.searchGameText.debounce(.seconds(1), scheduler: MainScheduler.instance).filter{ !$0.isEmpty }.flatMapLatest { searchText -> Observable<[Game]> in
            return server.searchGame(name: searchText)
        }
        
        let allGameList = Observable.of(gameList, showAllGames, searchGames).merge().share()
        let gameListOutput = allGameList.map{ [SectionModel(model: "", items: $0.map{ $0.imgURL })] }.asDriver(onErrorJustReturn: [])
        
        let clearSearch = input.secondTabSelect.mapToVoid().asDriverOnErrorJustComplete()
        
        let enterGame = input.tapGameIndex.withLatestFrom(allGameList) { $1[$0].url }.flatMapLatest{
            server.getGameUrl(url: $0).trackActivity(self.indicator)
        }.asDriverOnErrorJustComplete()
        
        return Output( secondTabList: secondTabListOutput, gameImageUrls: gameListOutput, clearSearch: clearSearch, enterGame: enterGame)
    }
}
