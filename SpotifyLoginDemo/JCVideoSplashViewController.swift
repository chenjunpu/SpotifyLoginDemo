//
//  VideoSplashViewController.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/20.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

public enum ScalingMode{
    
    case Resize
    case ResizeAspect
    case ResizeAspectFill
}

public class JCVideoSplashViewController: UIViewController {
    //MARK:properties
    private let moviePlayer = AVPlayerViewController()
    private var moviePlayerSoundLevel: Float = 1.0
    private var contentUrl: NSURL = NSURL(){
        didSet{
            setMoviePlayer(contentUrl)
        }
    }
    
    private var videoFrame: CGRect = CGRect()
    private var startTime: CGFloat = 0.0
    private var duration: CGFloat = 0.0
    private var backgroundColor: UIColor = UIColor.blackColor(){
        didSet{
            view.backgroundColor = backgroundColor
        }
    }

    public var sound: Bool = true{
        didSet{
            if sound{
                moviePlayerSoundLevel = 1.0
            }else{
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    
    public var alpha: CGFloat = CGFloat(){
        didSet{
            moviePlayer.view.alpha = alpha
        }
    }
    
    public var alwaysRepeat: Bool = true{
        didSet{
            if alwaysRepeat {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification, object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    public var fillMode: ScalingMode = .ResizeAspectFill{
        didSet{
            
            switch fillMode{
            case.Resize:
                moviePlayer.videoGravity = AVLayerVideoGravityResize
            case.ResizeAspect:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspect
            case.ResizeAspectFill:
                moviePlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            }
        }
    }
    
    //MARK:life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()


    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    public override func viewDidAppear(animated: Bool) {
        
//        show moviePlayer
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK:method
    private func setMoviePlayer(url: NSURL){
        
    }

    func playerItemDidReachEnd(){
        
        
    }
}
