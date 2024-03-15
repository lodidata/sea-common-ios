//
//  CAGradientLayerConst.swift
//  DNYTY
//
//  Created by WL on 2022/6/16
//  
//
    

import Foundation

func kSubmitButtonLayer1(size: CGSize = CGSize()) -> CAGradientLayer {

   let gradientLayer = CAGradientLayer()
     let gradientColors = [UIColor(hexString: "#B030AB")!.cgColor,
                           UIColor(hexString: "#5767FD")!.cgColor
                          ]

    //定义每种颜色所在的位置
    let gradientLocations:[NSNumber] = [0.0, 1.0]

    //创建CAGradientLayer对象并设置参数
    gradientLayer.colors = gradientColors
    gradientLayer.locations = gradientLocations

    //设置渲染的起始结束位置（横向渐变）
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.frame = CGRect(origin: CGPoint(), size: size)
   return gradientLayer
}
