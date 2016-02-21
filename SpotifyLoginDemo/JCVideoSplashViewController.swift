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
    var contentUrl: NSURL = NSURL(){
        didSet{
            setMoviePlayer(contentUrl)
        }
    }
    
     var videoFrame: CGRect = CGRect()
     var startTime: CGFloat = 0.0
     var duration: CGFloat = 0.0
     var backgroundColor: UIColor = UIColor.blackColor(){
        didSet{
            view.backgroundColor = backgroundColor
        }
    }

    var sound: Bool = true{
        didSet{
            if sound{
                moviePlayerSoundLevel = 1.0
            }else{
                moviePlayerSoundLevel = 0.0
            }
        }
    }
    
    var alpha: CGFloat = CGFloat(){
        didSet{
            moviePlayer.view.alpha = alpha
        }
    }
    
    var alwaysRepeat: Bool = true{
        didSet{
            if alwaysRepeat {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification, object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    var fillMode: ScalingMode = .ResizeAspectFill{
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
        
        let videoCutter = JCVideoCutter()
        
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            
            if let path = videoPath as NSURL?{
                dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        self.moviePlayer.player = AVPlayer(URL: path)
                        self.moviePlayer.player?.play()
                        self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
                    }
                }
            }
        }
    }

    func playerItemDidReachEnd(){
        
        moviePlayer.player?.seekToTime(kCMTimeZero)
        moviePlayer.player?.play()
        
    }
}
