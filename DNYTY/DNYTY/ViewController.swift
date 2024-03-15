//
//  ViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/2
//  
//
    

import UIKit
//import AAInfographics
import SJVideoPlayer

class ViewController: ZKViewController {
//    var player: SJVideoPlayer {
//        let player = SJVideoPlayer()
//        player.defaultEdgeControlLayer.fixesBackItem = true;
//        player.urlAsset = SJVideoPlayerURLAsset(url: URL(string: "https://dh2.v.netease.com/2017/cg/fxtpty.mp4")!)
//        
//        let floatSmallViewTransitionController = SJFloatSmallViewTransitionController()
//        floatSmallViewTransitionController.layoutSize = CGSize(width: kScreenWidth - 20, height: (kScreenWidth - 20) * 200.0/355)
//        floatSmallViewTransitionController.layoutPosition = .center
//        floatSmallViewTransitionController.automaticallyEnterFloatingMode = false
//        player.floatSmallViewController = floatSmallViewTransitionController
//        player.defaultFloatSmallViewControlLayer.topAdapter.removeAllItems()
//        let backItem = SJEdgeControlButtonItem(image: RImage.close_w1(), target: nil, action: nil, tag: SJEdgeControlLayerTopItem_Back)
//        backItem.addAction(SJEdgeControlButtonItemAction(handler: { [weak player] _ in
//            guard let player = player else { return }
//            player.floatSmallViewController.dismissFloatView()
//        }))
//        player.defaultFloatSmallViewControlLayer.topAdapter.add(backItem)
//        player.defaultFloatSmallViewControlLayer.topAdapter.reload()
//        
//        return player
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hexString: "#EDEEF3")
        
        
        
        
        
       
        
//        let aaChartView = AAChartView()
//        view.addSubview(aaChartView)
//        aaChartView.snp.makeConstraints { make in
//            make.left.equalTo(16)
//            make.right.equalTo(-16)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
//            make.height.equalTo(aaChartView.snp.width).multipliedBy(256.0/343)
//        }
        
        // 初始化图表模型
        // 初始化图表模型
//                let chartModel = AAChartModel()
//                    .inverted(false)//是否翻转图形
//                    //.yAxisTitle("摄氏度")// Y 轴标题
//                    .legendEnabled(false)//是否启用图表的图例(图表底部的可点击的小圆点)
//                    //.tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
//                    .categories(["一月", "二月", "三月", "四月", "五月", "六月"])
//                    .colorsTheme(["#8849F1", "#FF9B00"])//主题颜色数组
//                    .margin(top: 30, right: 20, bottom: 40, left: 60)
//                    .series([
//                        AASeriesElement()
//                            .name("总流水")
//                            .type(.column)
//                            .borderWidth(10)
//                            .data([1000, 69000, 95000, 145000, 182000, 215000])
//                            .toDic()!,
//                        AASeriesElement()
//                            .name("总分红")
//                            .type(.line)
//                            .data([70000, 69000, 95000, 145000, 182000, 215000])
//                            .toDic()!
//                        ])
//                 
//                // 图表视图对象调用图表模型对象,绘制最终图形
//            aaChartView.aa_drawChartWithChartModel(chartModel)
//        
//        let btn = UIButton(type: .custom)
//        btn.setTitle("视频", for: .normal)
//        view.addSubview(btn)
//        btn.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(aaChartView.snp.bottom).offset(20)
//        }
//        
//        btn.rx.tap.bind { [weak self] in
//            guard let self = self else { return  }
//            self.navigator.show(segue: .player(url: URL(string: "https://dh2.v.netease.com/2017/cg/fxtpty.mp4")), sender: self, transition: .modal)
//        }.disposed(by: rx.disposeBag)
//        
        
    }
    
//    func showPlayer() {
//        let player = self.player
//        view.addSubview(player.view)
//        //player.view.isHidden = true
//        player.view.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.height.equalTo(player.view.snp.width).multipliedBy(9/16.0);
//        }
//
//        player.floatSmallViewController.showFloatView()
//    }


}

