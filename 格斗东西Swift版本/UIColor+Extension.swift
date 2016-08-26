//
//  UIColor+Extension.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/25.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation

import UIKit


extension UIColor {

    
    // 自定义颜色
    class  func colcorWithHex(hex:UInt) -> UIColor {
    
        let r:CGFloat = (CGFloat)((hex >> 16) & 0xFF)
        let g:CGFloat = (CGFloat)((hex >> 8) & 0xFF)
        let b:CGFloat = (CGFloat)((hex) & 0xFF)
        
        let color = UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
        
        return color
    }
    
    // 自定义颜色 和透明度
    class func colcorWithHex(hex:UInt,alpha:CGFloat) -> UIColor {
        
        let r:CGFloat = (CGFloat)((hex >> 16) & 0xFF)
        let g:CGFloat = (CGFloat)((hex >> 8) & 0xFF)
        let b:CGFloat = (CGFloat)((hex) & 0xFF)
        
        let color = UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
        
        return color
    }
    
}