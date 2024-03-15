//
//  ZKHomeBottomAboutView.swift
//  DNYTY
//
//  Created by WL on 2022/6/7
//  
//
    

import UIKit

class ZKHomeBottomAboutView: ZKView {
    
    var rightIconUrls: [URL?] = [] {
        didSet {
            
            rightView.removeAllSubviews()
            var taps: [Observable<Int>] = []
            for (index, url) in rightIconUrls.enumerated() {
                let btn = UIButton()
                btn.sd_setBackgroundImage(with: url, for: .normal)
                rightView.addArrangedSubview(btn)
                
                taps.append(btn.rx.tap.map{ index }.asObservable())
                
                btn.snp.makeConstraints { make in
                    make.size.equalTo(CGSize(width: 24, height: 24))
                }
            }
            Observable.from(taps).merge().bind(to: rightSelectIndex).disposed(by: rx.disposeBag)
        }
    }
    
    let leftView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let rightView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    let rightSelectIndex: PublishRelay<Int> = PublishRelay()
    
    override func makeUI() {
        addSubview(leftView)
        addSubview(rightView)
        
        leftView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(20)
        }
        
        rightView.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.equalTo(leftView)
        }
        
        let leftImages = [RImage.home_18()]
        //let rightImages = [RImage.home_ab1(), RImage.home_ab2(), RImage.home_ab3(), RImage.home_ab4(), RImage.home_ab5()]
        
        for image in leftImages {
            let btn = UIButton()
            btn.setBackgroundImage(image, for: .normal)
            leftView.addArrangedSubview(btn)
            btn.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 24, height: 24))
            }
        }
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension Reactive where Base: ZKHomeBottomAboutView {
    var rightIconUrls: Binder<[URL]> {
        Binder(self.base) { view, urls in
            view.rightIconUrls = urls
        }
    }
    
    
}
