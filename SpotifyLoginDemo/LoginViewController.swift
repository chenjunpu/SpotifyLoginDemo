//
//  LoginViewController.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/20.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

class LoginViewController: JCVideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupVideoBackground()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupVideoBackground(){
        
        let path = NSBundle.mainBundle().pathForResource("m", ofType: "mp4")

        let url = NSURL.fileURLWithPath(path!)
        
        videoFrame = view.frame
        fillMode = .ResizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8

        contentUrl = url
        view.userInteractionEnabled = false

    }
}
