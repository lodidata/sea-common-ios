//
//  ZKMacros.swift
//  ZKBaseSwiftProject
//
//  Created by guina on 2021/6/18.
//  Copyright © 2021 zk. All rights reserved.
//

import Foundation
import UIKit

func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) -> UIColor {
    UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}

func amount375( _ amount: CGFloat) -> CGFloat {
    amount/375
}

func kShowPrompt(text: String) {
    UIApplication.appDeltegate.window?.showHUDMessage(text)
}

func kSystemFont(_ fontSize: CGFloat) -> UIFont {
    UIFont.systemFont(ofSize: fontSize)
}

func kMediumFont(_ fontSize: CGFloat) -> UIFont {
    UIFont.systemFont(ofSize: fontSize, weight: .medium)
}
extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}

extension Float {
    var stringValue: String {
        return NSDecimalNumber(value: self).stringValue
    }
}

extension Double {
    var stringValue: String {
        return NSDecimalNumber(value: self).stringValue
    }
}

extension UIImageView {
    func drawLine() {
        let size = self.frame.size
        UIGraphicsBeginImageContext(size) //开始画线 划线的frame
        self.image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        //设置线条终点形状
        UIGraphicsGetCurrentContext()?.setLineCap(.round)

        let line = UIGraphicsGetCurrentContext()
        // 设置颜色
        line?.setStrokeColor(UIColor.darkGray.cgColor)


        let lengths: [CGFloat] = [5.0, 2.0] //先画4个点再画2个点
        line?.setLineDash(phase: 0, lengths: lengths) //注意2(count)的值等于lengths数组的长度

        line?.move(to: CGPoint(x: 0.0, y: 2.0)) //开始画线
        line?.addLine(to: CGPoint(x: size.width, y: 2.0))
        line?.strokePath()
        // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.image = image
    }

    
}

import RxCocoa
import RxSwift
import RxDataSources
extension Reactive where Base: UICollectionView {
    var selectIndexPaths: Observable<[IndexPath]> {
        Observable.of(self.base.rx.itemSelected, self.base.rx.itemDeselected).merge().map{ [unowned collectionView = self.base] _ in
            
            guard let indexPaths = collectionView.indexPathsForSelectedItems else { return [] }
            
            return indexPaths
        }
    }
    
    var selectIndexPathsBinder: Binder<[IndexPath]> {
        Binder(self.base) { collectionView, indexPaths in
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                for indexPath in indexPaths {
                    collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
            
            for indexPath in indexPaths {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            }
        }
    }
    
}

