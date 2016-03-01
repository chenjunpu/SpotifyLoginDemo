//
//  LoginViewController.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/3/1.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK:properties
    private lazy var userName: UITextField = {
        let text = UITextField()
       
        let white = UIColor.whiteColor()
        text.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: white])
        text.textColor = UIColor.whiteColor()
        text.backgroundColor = UIColor.grayColor()
        return text
    }()
    
    private lazy var passWord: UITextField = {
        let text = UITextField()
        
        let white = UIColor.whiteColor()
        text.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: white])
        text.textColor = UIColor.whiteColor()
        text.backgroundColor = UIColor.grayColor()
        return text
    }()
    
    private lazy var loginBtn: UIButton = {
       
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(red: 0, green: 195/255, blue: 0, alpha: 1)
        btn.setTitle("LOG IN", forState: .Normal)

        return btn
    }()
    
    //MARK:life cycle
    override func loadView() {
        super.loadView()
        
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = true

    }
    
    //MARK:method
    func setupUI(){
        
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        title = "LOGIN"
        
        navigationController?.navigationBarHidden = false
        
        view.addSubview(userName)
        view.addSubview(passWord)
        view.addSubview(loginBtn)
        
        userName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((userName.superview?.snp_top)!).multipliedBy(1).offset(200)
            make.right.equalTo((userName.superview?.snp_right)!)
            make.left.equalTo((userName.superview?.snp_left)!)
            make.height.equalTo(50)

        }
        
        passWord.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(userName.snp_bottom)
            make.right.equalTo((userName.superview?.snp_right)!)
            make.left.equalTo((userName.superview?.snp_left)!)
            make.height.equalTo(50)

        }
        
        loginBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(passWord.snp_bottom).multipliedBy(1).offset(0)
            make.right.equalTo((userName.superview?.snp_right)!)
            make.left.equalTo((userName.superview?.snp_left)!)
            make.height.equalTo(50)
        }

        
    }
}
