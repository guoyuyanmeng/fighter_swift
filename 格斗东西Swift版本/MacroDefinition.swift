//
//  MacroDefinition.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/25.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation

import UIKit



/**
 **     定义全局常量代替OC项目中的PrefixHeader.pch文件，
 **     因你swift共享一䕏命名空间，所以只蹉不批private的ﻖ在其他地方就可以直接调用
 **
**/

// MARK: - 第三方key

//微信相关
let WX_BASE_URL = "https://api.weixin.qq.com/sns"
let WX_App_ID = "wxe69b91d3503144ca"
let WX_App_Secret = "cadaab54424da8be313935d91f8fbbf4"
let WXLoginSecret_Key = "quanjijia123456"

//微博相关
let WB_App_ID = "3097376602"
let WB_App_Secret = "921bba0ec52253b495276d90468e0b43"

//微博相关
let Mob_App_ID = "1374acb38a63a"
let Mob_App_Secret = "b5cbf02b604d984f527115748de70890"

//qq相关
let QQ_App_ID = "1105296095"
let QQ_App_Secret = "yXgKRmgLcOspLa74"



// MARK: - 通知

let WXLoginResultNoti = "WXLoginResutlNoti"
let WXShareResultNoti = "WXShareResultNoti"
let QQShareResultNoti = "QQShareResultNoti"
let RechargeResultNoti = "RechargeOrCharge"
let LoginNoti = "LoginNotifacation"
let QQShareResponse = "addShareResponse"
let TaskNotification = "taskNotification"
let EditNotification = "editNotification"

// MARK: - 常量

// 定义屏幕宽高
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

//和750的比例
let SCALE =  (SCREEN_WIDTH / (750 / 2))

//已登陆的用户信息
let LoginUser = "loginUser"



//showType区分正式版，和编辑预览版的字断
let SHOWTYPE  = "showType"

//类别（综合格斗、拳击、散打等等
let CATEGORIES = "categories"
let TEACH_CATEGORIES = "teachCategories"