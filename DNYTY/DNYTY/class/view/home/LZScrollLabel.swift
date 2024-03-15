//
//  ScrollLabel.swift
//  ScrollLabel
//
//  Created by Lizhi on 2022/3/3.
//  Copyright © 2022年 lizhi. All rights reserved.
//

import UIKit

open class LZScrollLabel: UIView {
    private(set) var scrollView: UIScrollView!
    private(set) var mainLabel: UILabel!
    private var label2: UILabel!
    /// 速度
    open var scrollSpeed: Double = 50
    open var labelSpacing: CGFloat = 20
    open var text: String? {
        didSet {
          self.setTitle(
            self.text ?? "", self.mainLabel.textColor, self.mainLabel.textAlignment, self.mainLabel.font
          )
        }
    }
    
    var alwayScroll: Bool = true

    private(set) var isStartScroll = false

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.setupSubviews(frame)
        

    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.stopAnimate()
    }

    private func setupSubviews(_ frame: CGRect) {
        self.scrollView = UIScrollView()
        self.addSubview(self.scrollView)
        self.scrollView.frame = frame
        self.scrollView.isScrollEnabled = false

        self.mainLabel = UILabel()
        self.label2 = UILabel()
        self.scrollView.addSubview(self.mainLabel)
        self.scrollView.addSubview(self.label2)
        self.mainLabel.textColor = UIColor.orange
        self.label2.textColor = UIColor.orange
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        self.scrollView.frame = self.bounds
        
        let mainLabelW = self.mainLabel.frame.size.width
        let scrollW = self.scrollView.frame.size.width
        
        let isCanScroll = mainLabelW > scrollW
        if self.isStartScroll && (alwayScroll || isCanScroll) {
            
            self.label2.isHidden = false
            self.scrollView.contentSize = CGSize(
                width: (mainLabelW + scrollW + labelSpacing) * 2, height: scrollView.height
            )
            self.mainLabel.left = scrollW + labelSpacing
            self.mainLabel.centerY = scrollView.height/2
            self.label2.left = self.mainLabel.right + labelSpacing + scrollW
            self.label2.centerY = scrollView.height/2
            self.scrollView.layer.removeAllAnimations()
            self.setAnimate()
        } else {
            self.scrollView.contentOffset = CGPoint.zero
            self.mainLabel.center = self.scrollView.center
            self.mainLabel.left = 0
            self.scrollView.layer.removeAllAnimations()
            
            self.label2.isHidden = true
        }
    }

    func setAnimate() {
        
        let isCanScroll = self.mainLabel.frame.size.width > self.scrollView.frame.size.width

        guard self.isStartScroll && (alwayScroll || isCanScroll) else {
           return
        }
        
        let scrollW = mainLabel.width + scrollView.width + labelSpacing
        let scrollInterval = scrollW / self.scrollSpeed
        self.scrollView.layer.removeAllAnimations()


        let animation = CABasicAnimation(keyPath: "bounds.origin")
        animation.duration = scrollInterval
        animation.repeatCount = MAXFLOAT
        animation.timingFunction = CAMediaTimingFunction.linear
        animation.isRemovedOnCompletion = false
        animation.toValue = CGPoint(x: scrollW, y: 0)
        scrollView.layer.add(animation, forKey: "scroll")

//        UIView.animate(
//            withDuration: scrollInterval, delay: 0, options: [.curveLinear, .repeat, .beginFromCurrentState]
//        ) { [weak self] in
//            guard let self = self else { return }
//            self.scrollView.contentOffset = CGPoint(x: scrollW, y: 0)
//        } completion: { [weak self] finished in
//
//            guard let self = self else { return }
//            print(self.scrollView.contentOffset.x)
//            print(scrollW)
//            if finished {
//                if self.isStartScroll && (self.alwayScroll || isCanScroll) {
//                    self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
//                    self.setAnimate()
//                } else {
//                    print("-- 动画被停止了")
//                }
//            }
//        }

    }

    open func startAnimate() {
    self.isStartScroll = true
    self.setNeedsLayout()
    self.layoutIfNeeded()
    }

    open func stopAnimate() {
    self.isStartScroll = false
    self.scrollView.layer.removeAllAnimations()
    
    }

    // MARK: - public method

    /*
     * title: label内容
     * alignment: 文字对齐方式
     * font: 字体大小
     */
    open func setTitle(
    _ title: String, _ color: UIColor = UIColor.red, _ alignment: NSTextAlignment = .left,
    _ font: UIFont = UIFont.systemFont(ofSize: 15)
    ) {
    self.configLabel(self.mainLabel, title: title, color: color, alignment: alignment, font: font)

    self.configLabel(self.label2, title: title, color: color, alignment: alignment, font: font)
    self.setNeedsLayout()
    self.layoutIfNeeded()
    }

    private func configLabel(
    _ label: UILabel, title: String, color: UIColor, alignment: NSTextAlignment, font: UIFont
    ) {
    label.text = title
    label.textAlignment = alignment
    label.font = font
    label.textColor = color
    label.sizeToFit()
    }
}

