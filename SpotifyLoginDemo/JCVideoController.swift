//
//  JCLoginController.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/22.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit
import AVFoundation

class JCVideoController: UIViewController {

    
    //MARK:properties
    private var avplayer: AVPlayer?
    var url: NSURL?

    lazy var videoView: UIView = UIView(frame: UIScreen.mainScreen().bounds)
    lazy var gradientView: UIView = UIView(frame: UIScreen.mainScreen().bounds)
    lazy var contentView: UIView = UIView(frame: UIScreen.mainScreen().bounds)
    
    //MARK:life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        add subView
        gradientView.backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(videoView)
        self.view.addSubview(gradientView)
        self.view.addSubview(contentView)
        
//        Set up player
        setUpPlayer()
        
//        Config player
        ConfigPlayer()
        
//        Config dark gradient view
        ConfigGradientview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        avplayer?.pause()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        avplayer?.play()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
    
    //MARK:methed
    func playerItemDidReachEnd(notification: NSNotification){
        let p = notification.object
        
        p?.seekToTime(kCMTimeZero)
    }
    
    func playerStartPlaying(){
        
        avplayer?.play()
    }

}

// MARK: - set background Video
extension JCVideoController{
    
    private func setUpPlayer(){
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
        }catch{
        }
        
        //        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("m", ofType: "mp4")!)
        let avAsset = AVAsset(URL: self.url!)
        let avPlayerItem = AVPlayerItem(asset: avAsset)
        avplayer = AVPlayer(playerItem: avPlayerItem)
        
        let avPlayerLayer = AVPlayerLayer(player: avplayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayerLayer.frame = UIScreen.mainScreen().bounds
        
        videoView.layer.addSublayer(avPlayerLayer)
        
    }
    
    private func ConfigPlayer(){
        
        avplayer?.seekToTime(kCMTimeZero)
        avplayer?.volume = 0.0
        avplayer?.actionAtItemEnd = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd:", name: AVPlayerItemDidPlayToEndTimeNotification, object: self.avplayer?.currentItem)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerStartPlaying", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    private func ConfigGradientview(){
        
        let gradient = CAGradientLayer()
        gradient.frame = UIScreen.mainScreen().bounds
        
        gradientView.layer.insertSublayer(gradient, atIndex: 0)
        
    }
}