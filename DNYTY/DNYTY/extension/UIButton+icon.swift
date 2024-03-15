//
//  UIButton+icon.swift
//  ZKBaseSwiftProject
//
//  Created by guina on 2021/6/19.
//  Copyright © 2021 zk. All rights reserved.
//

import Foundation
import UIKit

@objc extension UIButton {
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
             
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
             
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        }
         
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
            spacing: CGFloat) {
        let imageSize = self.currentImage?.size ?? CGSize()
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])

        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets

        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + spacing/4),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -(imageSize.height + spacing/4), right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + spacing/4),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: (titleSize.height + spacing/4), right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2 + spacing/2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                right: -(titleSize.width * 2 + spacing/2))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing/2)
            imageInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
        }
}


extension UIButton {
    /// 渐变背景
    @discardableResult
    func backgroundGradient<T: UIButton>(_ colours: [UIColor],
                                         _ isVertical: Bool = false,
                                         _ state: UIControl.State) -> T {
        let gradientLayer = CAGradientLayer()
        //几个颜色
        gradientLayer.colors = colours.map { $0.cgColor }
        //颜色的分界点
        gradientLayer.locations = [0.2,1.0]
        //开始
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        //结束,主要是控制渐变方向
        gradientLayer.endPoint  = isVertical == true ? CGPoint(x: 0.0, y: 1.0) : CGPoint(x: 1.0, y: 0)
        //多大区域
        gradientLayer.frame = self.bounds.isEmpty ? CGRect(x: 0, y: 0, width: 320, height: 30) : self.bounds
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            gradientLayer.render(in: context)
            
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            setBackgroundImage(outputImage, for: state)
        }
        return self as! T
    }
}
