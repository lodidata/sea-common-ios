//
//  UIButton+ext.swift
//  DNYTY
//
//  Created by WL on 2022/6/17
//  
//
    

import Foundation

extension UIButton {
    func zk_setContentInsets(insets: UIEdgeInsets) {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            
            configuration.contentInsets = NSDirectionalEdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
            self.configuration = configuration
            
        } else {
            self.contentEdgeInsets = insets
        }
        
    }
}
