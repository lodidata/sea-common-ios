//
//  WLExtension.swift
//  DNYTY
//
//  Created by wulin on 2022/6/16.
//

import UIKit

extension String {
    
    func showPrefixString(_ num: Int = 10) -> String{
        if self.count >= num {
            return String(self.prefix(num))
        } else {
            return self
        }
    }
    func heightWithText(_ size: CGFloat = 15, _ padding: CGFloat = 30) -> CGFloat {
        // 计算字符串的宽度，高度
        let font:UIFont! = kSystemFont(size)
        let attributes = [NSAttributedString.Key.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: CGSize.init(width: kScreenWidth - padding, height: 99999999), options: option, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        print("rect:\(rect)")
        return rect.height
    }
}
extension NSNumber {
    func divide100() -> NSDecimalNumber {
        let originNumber = NSDecimalNumber.init(decimal: self.decimalValue)
        let divideNumber = NSNumber.init(string: "100")
        if let number = divideNumber {
            let roundingBehavior = NSDecimalNumberHandler.init(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)

            return originNumber.dividing(by: NSDecimalNumber(decimal: number.decimalValue), withBehavior: roundingBehavior)
        }
        return 0
//        let result = self.doubleValue / 100.0
//        let str = String.init(format: "%.2f", result)
//        return NSNumber.init(string: str) ?? 0
    }
    func multiply100() -> NSDecimalNumber {
        let originNumber = NSDecimalNumber.init(decimal: self.decimalValue)
        let divideNumber = NSNumber.init(string: "100")
        if let number = divideNumber {
            let roundingBehavior = NSDecimalNumberHandler.init(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)

            return originNumber.multiplying(by: NSDecimalNumber(decimal: number.decimalValue), withBehavior: roundingBehavior)
        }
        return 0
//        let result = self.doubleValue * 100.0
//        let str = String.init(format: "%.2f", result)
//        return NSNumber.init(string: str) ?? 0
    }
    func toNSDecimalNumber() -> NSDecimalNumber {
        return NSDecimalNumber.init(decimal: self.decimalValue)
    }
}
