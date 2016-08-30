//
//  SliderManageController.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/18.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation
import UIKit


/**
 The drawer direction defines the direction that a `SliderManageController` instance's `paneView` can be opened in.
 
 The values can be masked in some (but not all) cases. See the parameters of individual methods to ensure compatibility with the `MSDynamicsDrawerDirection` that is being passed.
 */
struct FTDynamicsSliderDirection : OptionSetType {
    let rawValue: Int
    
    init(rawValue: Int) { self.rawValue = rawValue }
    static let  None       = FTDynamicsSliderDirection(rawValue: 0)
    static let  Top        = FTDynamicsSliderDirection(rawValue: 1)
    static let  Left       = FTDynamicsSliderDirection(rawValue: 2)
    static let  Bottom     = FTDynamicsSliderDirection(rawValue: 4)
    static let  Right      = FTDynamicsSliderDirection(rawValue: 8)
    static let  Horizontal:FTDynamicsSliderDirection = [Left, Right]
    static let  Vertical:FTDynamicsSliderDirection   = [Top, Bottom]
}


/**
 The possible drawer/pane visibility states of `SliderManageController`.
 @see paneState
 @see setPaneState:animated:allowUserInterruption:completion:
 @see setPaneState:inDirection:animated:allowUserInterruption:completion:
 */
enum SliderManageControllerState {
    case closed   // Slider view entirely hidden by pane view
    case open     // Slider view revealed to open width
    case openWide // Slider view entirely visible
}

var sliderActionBlock: (() -> (FTDynamicsSliderDirection))?



func sliderDirectionIsNonMasked(sliderDirection:FTDynamicsSliderDirection) -> BooleanType {
    switch sliderDirection {
    case FTDynamicsSliderDirection.None
    case Top
    case Left
    case Bottom
    case Right
        return true
    defaul:
        return false
    }
}



class SliderManageController: UIViewController {
    
    var shouldAlignStatusBarToPaneView:BooleanType?
    
    var paneViewController:UIViewController?
    var sliderViewController:UIViewController?
    
    var sliderView:UIView?
    var paneView:UIView?
    
    var paneState:SliderManageControllerState?
    
    // 设置主界面点击或者滑动弹出用户中心的响应区域宽度
    var openSliderWith:Float?
    
    
}