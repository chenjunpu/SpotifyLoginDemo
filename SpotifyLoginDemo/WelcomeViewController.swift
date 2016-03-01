//
//  LoginViewController.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/23.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

let PictureCycleCellID = "PictureCycleCellID"

class WelcomeViewController: JCVideoController {
    
    //MARK:properties
    lazy private var loginBtn: UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.darkGrayColor()
        btn.setTitle("LOG IN", forState: .Normal)
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        btn.addTarget(self, action: "logInBtnDidClick", forControlEvents: .TouchUpInside)
        
        return btn
    }()
    
    lazy private var signUpBtn: UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(red: 0, green: 195/255, blue: 0, alpha: 1)
        btn.setTitle("SIGN UP", forState: .Normal)
        btn.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        
        btn.addTarget(self, action: "logInBtnDidClick", forControlEvents: .TouchUpInside)
        
        return btn
        
    }()
    
    lazy private var icon: UIImageView = {
       
        let imgView = UIImageView()
        imgView.image = UIImage(named: "login-secondary-logo")
        
        return imgView
    }()
    
    private var PictureCycleView: JCLoopView?
    
    private lazy var titleArray: [String] = {
        let arr = ["Welcome\nSign up for free music on your phone,\ntablet and computer.",
            "Browse\nExplore top tracks,new releases and\nthe right playlist for every moment.",
            "Search\nLooking for that special album or artist?\nJust search and hit Play!",
            "running\nMusic that perfectly matches\nyour tempo.",
            "Your Library\nSave any song,album or artist to your\nown music collection."]
        return arr
    }()
    
    
    
    //MARK:life cycle
    override func loadView() {
        super.loadView()
        
        setUpUI()
    }
    
    override func viewDidLoad() {
        
        self.url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("m", ofType: "mp4")!)
        
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK:UI actions
    @objc private func logInBtnDidClick(){
        
        let vc = LoginViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK:UI method
extension WelcomeViewController{
    
    private func setUpUI(){

//        add CollectionView
        PictureCycleView = JCLoopView(titleArray: self.titleArray)
        
        PictureCycleView?.frame = self.contentView.bounds
        
        self.contentView.addSubview(PictureCycleView!)
        
//        add loginBtn
        self.contentView.addSubview(loginBtn)
        
        loginBtn.snp_makeConstraints { (make) -> Void in
        
        make.left.equalTo((loginBtn.superview?.snp_left)!).multipliedBy(1).offset(0)
        make.bottom.equalTo((loginBtn.superview?.snp_bottom)!).multipliedBy(1).offset(0)
        make.right.equalTo((loginBtn.superview?.snp_centerX)!).multipliedBy(1).offset(0)
        make.height.equalTo(45)
        }
        
//        add signUpBtn
        self.contentView.addSubview(signUpBtn)
        
        signUpBtn.snp_makeConstraints { (make) -> Void in
            
            make.left.equalTo((signUpBtn.superview?.snp_centerX)!).multipliedBy(1).offset(0)
            make.bottom.equalTo((signUpBtn.superview?.snp_bottom)!).multipliedBy(1).offset(0)
            make.right.equalTo((signUpBtn.superview?.snp_right)!).multipliedBy(1).offset(0)
            make.height.equalTo(45)
        }
        
//        add icon
        self.contentView.addSubview(icon)
        
        icon.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((icon.superview?.snp_top)!).multipliedBy(1).offset(100)
            make.centerX.equalTo(contentView.snp_centerX)
            make.size.equalTo(CGSize(width: 218, height: 66))

        }
        
    }
}




