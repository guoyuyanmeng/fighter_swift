//
//  UserBean.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/26.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation

class UserBean: NSObject ,NSCoding{
    
    var uid:String?
    var userId:String?
    var unionId:String?
    var unionuserid:String?
    var openId:String?
    var oldUserId:String?
    
    
    //微信
    var wxopenId:String?
    var wxHeaderPic:String?
    var wxName:String?
    
    var imei:String?
    var token:String?
    var registertime:String?
    var stemfrom:String?
    
    
    var username:String?
    var birthday:String?
    var tel:String?
    var sex:String?
    var realname:String?
    
    var telmodel:String?
    var interestList:NSArray?
    var height:String?
    var weight:String?
    var address:String?
    var headpic:String?//头像
    var email:String?
    var password:String?
    var remarks:String?
    
    var lastlogintime:String?
    var lastModifyName:String?
    var effect:String?
    
    var cardType:String?
    var cardNo:String?
    
    
    /**
     *  个人主页新增的字断，没有进行归档
     */
    var followCount:String?
    var fansCount:String?
    var dynamicCount:String?
    var name:String?
    var background:String?
    var identity:String?
    var headUrl:String?
    var query:String?
    var brief:String?
    var boxerRaceInfos:String?
    var standings:String?
    var boxerId:String?
    var coachId:String?
    var win:String?
    var fail:String?
    var draw:String?
    var knockout:String?
    var isBoxerChecked:String?
    
   
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        self.init()
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.userId = aDecoder.decodeObjectForKey("userId") as? String
        self.unionId = aDecoder.decodeObjectForKey("unionId") as? String
        self.unionuserid = aDecoder.decodeObjectForKey("unionuserid") as? String
        self.openId = aDecoder.decodeObjectForKey("openId") as? String
        self.oldUserId = aDecoder.decodeObjectForKey("olduserid") as? String
        self.wxopenId = aDecoder.decodeObjectForKey("wxopenId") as? String
        
        self.imei = aDecoder.decodeObjectForKey("imei") as? String
        self.token = aDecoder.decodeObjectForKey("token") as? String
        self.stemfrom = aDecoder.decodeObjectForKey("stemfrom") as? String
        
        
        self.username = aDecoder.decodeObjectForKey("username") as? String
        self.birthday = aDecoder.decodeObjectForKey("birthday") as? String
        self.tel = aDecoder.decodeObjectForKey("tel") as? String
        self.sex = aDecoder.decodeObjectForKey("sex") as? String
        self.realname = aDecoder.decodeObjectForKey("realname") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.height = aDecoder.decodeObjectForKey("height") as? String
        self.weight = aDecoder.decodeObjectForKey("weight") as? String
        self.address = aDecoder.decodeObjectForKey("address") as? String
        self.remarks = aDecoder.decodeObjectForKey("remorks") as? String
        self.headpic = aDecoder.decodeObjectForKey("headpic") as? String
        
        self.telmodel = aDecoder.decodeObjectForKey("telmodel") as? String
        self.interestList = aDecoder.decodeObjectForKey("interestList") as? NSArray
        
        self.registertime = aDecoder.decodeObjectForKey("registertime") as? String
        self.lastlogintime = aDecoder.decodeObjectForKey("lastlogintime") as? String
        self.lastModifyName = aDecoder.decodeObjectForKey("lastModifyName") as? String
        self.effect = aDecoder.decodeObjectForKey("effect") as? String
        
        self.cardType = aDecoder.decodeObjectForKey("cardType") as? String
        self.cardNo = aDecoder.decodeObjectForKey("cardNo") as? String
        
        
        /**
         *  个人主页新增的字断，没有进行归档
         */
        self.followCount = aDecoder.decodeObjectForKey("followCount") as? String
        self.fansCount = aDecoder.decodeObjectForKey("fansCount") as? String
        self.dynamicCount = aDecoder.decodeObjectForKey("dynamicCount") as? String
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.background = aDecoder.decodeObjectForKey("background") as? String
        self.identity = aDecoder.decodeObjectForKey("identity") as? String
        self.headUrl = aDecoder.decodeObjectForKey("headUrl") as? String
        self.query = aDecoder.decodeObjectForKey("query") as? String
        self.brief = aDecoder.decodeObjectForKey("brief") as? String
        self.boxerRaceInfos = aDecoder.decodeObjectForKey("boxerRaceInfos") as? String
        self.standings = aDecoder.decodeObjectForKey("standings") as? String
        self.boxerId = aDecoder.decodeObjectForKey("boxerId") as? String
        self.coachId = aDecoder.decodeObjectForKey("coachId") as? String
        self.win = aDecoder.decodeObjectForKey("win") as? String
        self.fail = aDecoder.decodeObjectForKey("fail") as? String
        self.draw = aDecoder.decodeObjectForKey("draw") as? String
        self.knockout = aDecoder.decodeObjectForKey("knockout") as? String
        self.isBoxerChecked = aDecoder.decodeObjectForKey("isBoxerChecked") as? String
        
        
    }
    
    func encodeWithCoder(aDecoder: NSCoder)  {
        
        aDecoder.encodeObject(self.uid, forKey: "uid")
        aDecoder.encodeObject(self.userId, forKey: "userId")
        aDecoder.encodeObject(self.unionId, forKey: "unionId")
        aDecoder.encodeObject(self.unionuserid, forKey: "unionuserid")
        aDecoder.encodeObject(self.openId, forKey: "openId")
        aDecoder.encodeObject(self.oldUserId, forKey: "olduserid")
        aDecoder.encodeObject(self.wxopenId, forKey: "wxopenId")
        
        aDecoder.encodeObject(self.imei, forKey: "imei")
        aDecoder.encodeObject(self.token, forKey: "token")
        aDecoder.encodeObject(self.stemfrom, forKey: "stemfrom")
        
        
        aDecoder.encodeObject(self.username, forKey: "username")
        aDecoder.encodeObject(self.birthday, forKey: "birthday")
        aDecoder.encodeObject(self.tel, forKey: "tel")
        aDecoder.encodeObject(self.sex, forKey: "sex")
        aDecoder.encodeObject(self.realname, forKey: "realname")
        aDecoder.encodeObject(self.email, forKey: "email")
        aDecoder.encodeObject(self.height, forKey: "height")
        aDecoder.encodeObject(self.weight, forKey: "weight")
        aDecoder.encodeObject(self.address, forKey: "address")
        aDecoder.encodeObject(self.remarks, forKey: "remorks")
        aDecoder.encodeObject(self.headpic, forKey: "headpic")
        
        aDecoder.encodeObject(self.telmodel, forKey: "telmodel")
        aDecoder.encodeObject(self.interestList, forKey: "interestList")
        
        aDecoder.encodeObject(self.registertime, forKey: "registertime")
        aDecoder.encodeObject(self.lastlogintime, forKey: "lastlogintime")
        aDecoder.encodeObject(self.lastModifyName, forKey: "lastModifyName")
        aDecoder.encodeObject(self.effect, forKey: "effect")
        
        aDecoder.encodeObject(self.cardType, forKey: "cardType")
        aDecoder.encodeObject(self.cardNo, forKey: "cardNo")
        
        
        /**
         *  个人主页新增的字断，没有进行归档
         */
        aDecoder.encodeObject(self.followCount, forKey: "followCount")
        aDecoder.encodeObject(self.fansCount, forKey: "fansCount")
        aDecoder.encodeObject(self.dynamicCount, forKey: "dynamicCount")
        aDecoder.encodeObject(self.name, forKey: "name")
        aDecoder.encodeObject(self.background, forKey: "background")
        aDecoder.encodeObject(self.identity, forKey: "identity")
        aDecoder.encodeObject(self.headUrl, forKey: "headUrl")
        aDecoder.encodeObject(self.query, forKey: "query")
        aDecoder.encodeObject(self.brief, forKey: "brief")
        aDecoder.encodeObject(self.boxerRaceInfos, forKey: "boxerRaceInfos")
        aDecoder.encodeObject(self.standings, forKey: "standings")
        aDecoder.encodeObject(self.boxerId, forKey: "boxerId")
        aDecoder.encodeObject(self.coachId, forKey: "coachId")
        aDecoder.encodeObject(self.win, forKey: "win")
        aDecoder.encodeObject(self.fail, forKey: "fail")
        aDecoder.encodeObject(self.draw, forKey: "draw")
        aDecoder.encodeObject(self.knockout, forKey: "knockout")
        aDecoder.encodeObject(self.isBoxerChecked, forKey: "isBoxerChecked")
    }

    
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
    
    // 出生日期
    func formaterBirthday() -> NSString {
        
        if self.birthday != nil && self.birthday!.characters.count > 0 {
            
            let array:NSArray = self.birthday!.componentsSeparatedByString(" ") as NSArray
            let dateFormater:NSDateFormatter = NSDateFormatter.init()
            dateFormater.dateFormat = "yyyy-MM-dd"
            
            let date:NSDate = dateFormater.dateFromString(array.objectAtIndex(0) as! String)!
            
            return dateFormater.stringFromDate(date)
        }
        
        return ""
    }
    
    
    // MARK:  - 验证登录
    
    class func isLogin() ->Bool {
    
        let loginUserData:NSData? = NSUserDefaults.standardUserDefaults().objectForKey(LoginUser) as? NSData
        
        if (loginUserData != nil) {
            
            return true
        }else {
            return false
        }
    }
    
    
    class func loginUser() ->UserBean {
        
        let localUserData:NSData? = NSUserDefaults.standardUserDefaults().objectForKey(LoginUser) as? NSData
        let userbean:UserBean? = NSKeyedUnarchiver.unarchiveObjectWithData(localUserData!) as? UserBean
        
        return userbean!
    }
    
    
    
    
}
