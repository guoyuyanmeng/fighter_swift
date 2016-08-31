//
//  SliderManageController.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/18.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation
import UIKit



// MARK: - prepare
/**
 The drawer direction defines the direction that a `SliderManageController` instance's `paneView` can be opened in.
 
 The values can be masked in some (but not all) cases. See the parameters of individual methods to ensure compatibility with the `MSDynamicsDrawerDirection` that is being passed.
 */
struct SliderDirectionOption : OptionSetType {
    let rawValue: UInt
    
//    internal init(rawValue: UInt) //{ self.rawValue = rawValue }
    static let  None       = SliderDirectionOption(rawValue: 0)
    static let  Top        = SliderDirectionOption(rawValue: 1 << 0)
    static let  Left       = SliderDirectionOption(rawValue: 2 << 1)
    static let  Bottom     = SliderDirectionOption(rawValue: 4 << 2)
    static let  Right      = SliderDirectionOption(rawValue: 8 << 3)
    static let  Horizontal:SliderDirectionOption = [Left, Right]
    static let  Vertical:SliderDirectionOption   = [Top, Bottom]
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


func SliderDirectionIsNonMasked(sliderDirection:SliderDirectionOption) -> BooleanType {
    
    switch sliderDirection {
    case  [.None],[.Top],[.Left],[.Bottom],[.Right]:
        return true
    default:
        return false
    }
    
}


func SliderDirectionIsCardinal(sliderDirection:SliderDirectionOption) -> BooleanType {
    
    switch sliderDirection {
    case  [.Top],[.Left],[.Bottom],[.Right]:
        return true
    default:
        return false
    }
    
}

func SliderDirectionIsValid(sliderDirection:SliderDirectionOption) -> BooleanType {
    
    switch sliderDirection {
    case [.None],[.Top],[.Left],[.Bottom],[.Right],[.Horizontal],[.Vertical]:
        return true
    default:
        return false
    }

}

//func SliderDirectionActionForMaskedValues(direction:SliderDirectionOption,action:SliderActionBlock) {
//    
//    for var currentDirection = SliderDirectionOption.Top ; currentDirection <= SliderDirectionOption.Right ; currentDirection << = 1 {
//        
//    }
//    
//}

// MARK: - block 

typealias SliderActionBlock = ((SliderDirectionOption) -> ())
typealias ViewActionBlock =  ((UIView) -> ())

// MARK: - UIview extension
extension UIView {
    
//    func superviewHierarchyAction(viewAction:(UIView)->()) {
//        
//        viewAction(self)
//        self.superview?.superviewHierarchyAction(viewAction)
//    }
    
    func superviewHierarchyAction(viewAction:ViewActionBlock) {
        
        viewAction(self)
        self.superview?.superviewHierarchyAction(viewAction)
    }
}


// MARK: - Class
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







