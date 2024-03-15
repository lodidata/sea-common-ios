//
//  ZKVipEquityViewModel.swift
//  DNYTY
//
//  Created by WL on 2022/6/27
//  
//
    

import UIKit
import RxCocoa

class ZKVipEquityViewModel: ZKViewModel, ViewModelType {

    struct Input {
        let viewWillShow: Observable<Void>
        
    }
    
    struct Output {
        let bannerImageUrls: Driver<[URL]> //banner
        let levels: Driver<[ZKUserServer.LevelModel]>
        let currentLevel: Driver<ZKUserServer.LevelModel>
    }
    
    func transform(input: Input) -> Output {
        let server = ZKHomeServer()
        let userServer = ZKUserServer()
        let banners = input.viewWillShow.flatMap{ server.getBanner().trackActivity(self.indicator) }.share()
        let bannerImageUrlsOutput = banners.map{ list -> [URL] in
            list.compactMap{ b in
                URL(string: b.pic)
            }
        }.asDriver(onErrorJustReturn: [])
        
        let levels = input.viewWillShow.flatMap{ userServer.getLevelExplainList().trackActivity(self.indicator) }.share()
        let levelsOutput = levels.asDriver(onErrorJustReturn: [])
        
        let userLevel = input.viewWillShow.flatMapLatest{ userServer.getUserLevel().trackActivity(self.indicator) }.unwrap().share()
        
        let currentLevel = Observable.combineLatest(levels, userLevel).flatMap{ levels, userLevel -> Observable<ZKUserServer.LevelModel>  in
            let level = levels.first { leve in
                leve.name == userLevel.levelName
            }
            return level == nil ? .never() : .just(level!)
        }
        let currentLevelOutput = currentLevel.asDriverOnErrorJustComplete()
        return Output(bannerImageUrls: bannerImageUrlsOutput,  levels: levelsOutput, currentLevel: currentLevelOutput)
    }
}
