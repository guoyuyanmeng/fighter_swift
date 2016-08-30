//
//  SliderViewController.swift
//  格斗东西Swift版本
//
//  Created by kang on 16/8/18.
//  Copyright © 2016年 kang. All rights reserved.
//

import Foundation
import UIKit

class SliderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Property List
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // header view content
    
    @IBOutlet weak var avatarBtn: UIButton!
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var avatarBorder: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var WXloginBtn: UIButton!
    
    
    // footer view content
    
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var qqLabel: UILabel!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    
    // other property
    
    let _duibaConfig:NSInteger = 1;
    
    
    
    // MARK: - lift cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    
    // MARK: - 初始化
    
    func setSubviews() {
        
        self.view.backgroundColor = UIColor.colcorWithHex(0x191919)
        
        self.setNotification()
        
        self.setHeaderView()
        self.setFooterView()
        self.setTableView()
        
    }
    
    // 设置监听器
    func setNotification() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(wxLoginCallback), name: WXLoginResultNoti, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(phoneLoginedCallback), name: LoginNoti, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(rechargeCallback), name: RechargeResultNoti, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(phoneLoginedCallback), name: EditNotification, object: nil)
        
    }
    
    // 设置HeaderView ，显示用户信息
    func setHeaderView() {
        
        // 设置tableView头视图背景颜色
        self.headerView.backgroundColor = UIColor.colcorWithHex(0x191919)
        
        // 设置头像圆角
        self.avatarBtn.layer.masksToBounds = true
        self.avatarBtn.layer.cornerRadius = 40;
        
        //
        self.nameLabel.textColor = UIColor.colcorWithHex(0x505050)
        
        // 设置身高体重字体颜色
        self.heightLabel.textColor = UIColor.colcorWithHex(0xb4b4b4)
        self.weightLabel.textColor = UIColor.colcorWithHex(0xb4b4b4)
        
        
        // 设置登录按钮
        self.loginBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.WXloginBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.WXloginBtn.setTitleColor(UIColor.colcorWithHex(0xcccccc), forState: UIControlState.Highlighted)
    }
    
    
    // 设置footerView ,显示版本号
    func setFooterView() {
    
        // 设置tableView尾视图背景颜色
        self.footerView.backgroundColor = UIColor.colcorWithHex(0x191919)
        
        // 设置底部版本号和QQ群label字体颜色
        self.qqLabel.textColor = UIColor.colcorWithHex(0x828287)
        self.versionLabel.textColor = UIColor.colcorWithHex(0x828287)
        
        // iOS获取应用程序信息
        let infoDictionary:NSDictionary = NSBundle.mainBundle().infoDictionary!
        
        // 获取版本号:
        let version = (infoDictionary.objectForKey("CFBundleVersion"))!
        
        // 设置版本号
        self.versionLabel.text = "当前版本：".stringByAppendingString(version as! String)
    }
    
    
    // 设置登录以后显示的用户信息 tableView
    func setTableView() {
        
        // 注册tableView cell
        self.tableView.registerNib(UINib.init(nibName: "FTDrawerCell", bundle: nil), forCellReuseIdentifier:"tableCellId")
        self.tableView.registerNib(UINib.init(nibName: "FTDrawerPayCell", bundle: nil), forCellReuseIdentifier:"payCellId")
        self.tableView.registerNib(UINib.init(nibName: "FTLabelsCell", bundle: nil), forCellReuseIdentifier:"labelsCellId")
        
        // 设置tableView响应属性
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = self.footerView
        
        
        // 侧滑栏视图添加约束，只能展示屏幕宽度的70%
        let offsetX = SCREEN_WIDTH * 0.3
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        let rightConstraint:NSLayoutConstraint = NSLayoutConstraint.init(item: self.tableView,
                                                               attribute: NSLayoutAttribute.Right,
                                                               relatedBy: NSLayoutRelation.Equal,
                                                               toItem: self.view,
                                                               attribute: NSLayoutAttribute.Right,
                                                               multiplier: 1.0,
                                                               constant: -offsetX)
        
        
        
        self.tableView.addConstraint(rightConstraint)
        
    }
    
    // 设置未登录界面
    func setUnloginView() {
    
        // 显示登录按钮
        self.loginBtn.hidden = false
        self.WXloginBtn.hidden = false
        
        // 隐藏用户信息空间
        self.nameLabel.hidden = true
        self.sexLabel.hidden = true
        self.ageLabel.hidden = true
        self.heightLabel.hidden = true
        self.weightLabel.hidden = true
    }
    
    // 设置用户信息展示界面
    func setLoginedView() {
    
        // 显示登录按钮
        self.loginBtn.hidden = true
        self.WXloginBtn.hidden = true
        
        // 隐藏用户信息空间
        self.nameLabel.hidden = false
        self.sexLabel.hidden = false
        self.ageLabel.hidden = false
        self.heightLabel.hidden = false
        self.weightLabel.hidden = false
        
    }
    
    // MARK: - setter
    
    
    // MARK: - Adepter
    
    func adepter() {
    
        if UserBean.isLogin() {
            
            
        }
        
    }
    
    // 适配用户登录信息
    func headerViewAdepter() {
        
        let loginUser:UserBean? = UserBean.loginUser()
        
        if (loginUser != nil) {
            
            self.nameLabel.text = loginUser?.username
            self.ageLabel.text = loginUser!.age() as String
            self.sexLabel.text = loginUser?.sex
            self.weightLabel.text = loginUser?.weight
            self.heightLabel.text = loginUser?.height
            
            self.avatarBtn.setBackgroundImage(UIImage.init(named: loginUser!.headpic!), forState: UIControlState.Normal)
        }else {
        
            self.avatarBtn.setBackgroundImage(UIImage.init(named: "头像-空"), forState: UIControlState.Normal)
        }
        
    }
    
    
    
    // MARK: - 监听器响应
    
    func wxLoginCallback (noti: NSNotification) {
        
        let msg:NSString = noti.object as! NSString
        
        // 退出登录
        if msg.isEqualToString("SUCESS") {
            self.setLoginedView()
            self.headerViewAdepter()
        }
    }
    
    func phoneLoginedCallback (noti: NSNotification) {
        
        let msg:NSString = noti.object as! NSString
        // 退出登录
        if msg.isEqualToString("LOGOUT") {
            self.setUnloginView()
        }else {
            
            // 登录成功
            self.setLoginedView()
            self.headerViewAdepter()
            
        }
    }
    
    func rechargeCallback (noti: NSNotification) {
        
    }
    
   
    // MARK: - Button Response
    
    // header action
    
    @IBAction func avatarBtnAction(sender: AnyObject) {
        
    }
    
    @IBAction func editBtnAction(sender: AnyObject) {
        
    }
    
    @IBAction func loginBtnAction(sender: AnyObject) {
        
    }
    
    @IBAction func wxLoginBtnAction(sender: AnyObject) {
        
    }
    
    
    // footer action 
    
    @IBAction func settingBtnAction(sender: AnyObject) {
        
        
    }
    
    
    
    // MARK: - Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FTLabelsCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
}