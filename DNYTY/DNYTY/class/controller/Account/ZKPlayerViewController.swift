//
//  ZKPlayerViewController.swift
//  DNYTY
//
//  Created by WL on 2022/6/30
//  
//
    

import UIKit
import SJVideoPlayer

class ZKPlayerViewController: ZKViewController {
    
    let player: SJVideoPlayer = {
        let player = SJVideoPlayer()
        player.defaultEdgeControlLayer.isHiddenBackButtonWhenOrientationIsPortrait = true
        
        
        return player
    }()
    
    let backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(RImage.close_w1(), for: .normal)
        
        return btn
    }()
    
    let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        //"https://dh2.v.netease.com/2017/cg/fxtpty.mp4"
        
        guard let url = url else { return  }
        player.urlAsset = SJVideoPlayerURLAsset(url: url)
        
    }
    
    override func initSubView() {
        view.addSubview(player.view)
        hero.isEnabled = true
        player.view.hero.modifiers = [.translate( y: -200), .fade]
        
        player.defaultEdgeControlLayer.topContainerView.addSubview(backBtn)
        
        
        
//        player.defaultEdgeControlLayer.topAdapter.removeAllItems()
//        player.defaultEdgeControlLayer.topAdapter.reload()
        
    }
    
    override func layoutSubView() {
        player.view.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(player.view.snp.width).multipliedBy(9.0/16)
        }
        
        backBtn.snp.makeConstraints { make in
            make.right.equalTo(-5)
            make.top.equalTo(5)
            
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    override func bindViewModel() {
        backBtn.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        player.playbackObserver.playbackDidFinishExeBlock = { player in
            player.replay()
        }
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
