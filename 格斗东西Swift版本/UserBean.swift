//
//  UserBean.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/26.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation

class UserBean: NSObject {
    
    var userId:NSString?
    var unionId:NSString?
    var openId:NSString?
    var oldUserId:NSString?
    var imei:NSString?
    var token:NSString?
    var registertime:NSString?
    var stemfrom:NSString?
    var wxopenId:NSString?
    
    var username:NSString?
    var birthday:NSString?
    var tel:NSString?
    var sex:NSString?
    var realname:NSString?
    var cardType:NSString?
    var telmodel:NSString?
    var interestList:NSArray?
    var height:NSString?
    var weight:NSString?
    var address:NSString?
    
    var email:NSString?
    var lastModifyName:NSString?
    var effect:NSString?
    var uid:NSString?
    var remorks:NSString?
    var unionuserid:NSString?
    
    var cardNo:NSString?
    var headpic:NSString?//头像
    
    var lastlogintime:NSString?
    
    
    //微信
    var wxHeaderPic:NSString?
    var wxName:NSString?
    
    
    /**
     *  个人主页新增的字断，没有进行归档
     */
    
    var followCount:NSString?
    var fansCount:NSString?
    var dynamicCount:NSString?
    var name:NSString?
    var background:NSString?
    var identity:NSString?
    var headUrl:NSString?
    var query:NSString?
    var brief:NSString?
    var boxerRaceInfos:NSString?
    var standings:NSString?
    var boxerId:NSString?
    var coachId:NSString?
    var win:NSString?
    var fail:NSString?
    var draw:NSString?
    var knockout:NSString?
    var isBoxerChecked:NSString?
    
   
    //根据生日计算年龄 默认存储格式为yyyy-MM-dd
    func age() -> NSString {
        
        let birth:NSString = self.formaterBirthday()
        
        let dateFormater:NSDateFormatter = NSDateFormatter.init()
        dateFormater.dateFormat = "yyyy-MM-dd"
        
        
        let birthDate:NSDate = dateFormater.dateFromString(birth as String)!
        let currentDate:NSDate = NSDate.init()
        
        let timeInternal:NSTimeInterval = currentDate.timeIntervalSinceDate(birthDate)
        
        var age:Int = (Int)(timeInternal/365*24*3600);
        
        if age < 0  {
            age = 0
        }
        
        let string:String = String(age)
        return string
    }
    
    func formaterBirthday() -> NSString {
        
        if self.birthday != nil && self.birthday!.length > 0 {
            
            let array:NSArray = self.birthday!.componentsSeparatedByString(" ") as NSArray
            let dateFormater:NSDateFormatter = NSDateFormatter.init()
            dateFormater.dateFormat = "yyyy-MM-dd"
            
            let date:NSDate = dateFormater.dateFromString(array.objectAtIndex(0) as! String)!
            
            return dateFormater.stringFromDate(date)
        }
        
        return ""
    }
    
    
    // MARK: 验证登录
    
    class func isLogin() ->Bool {
    
        let loginUserData:NSData? = NSUserDefaults.standardUserDefaults().objectForKey(LoginUser) as? NSData
        
        if (loginUserData != nil) {
            
            return true
        }else {
            return false
        }
    }
    
    
    
}
