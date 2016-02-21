//
//  VideoCutter.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/20.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit
import AVFoundation

public class JCVideoCutter: NSObject {

    /**
     Block based method for crop video url
     
     - parameter url:        videoUrl Video url
     - parameter startTime:  The starting point of the video segments
     - parameter duration:   Total time, video length
     - parameter completion: completion closure
     */
    public func cropVideoWithUrl(videoUrl url:NSURL, startTime: CGFloat, duration: CGFloat, completion: ((videoPath: NSURL?, error: NSError?) -> Void)?){
    
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            
            let asset = AVURLAsset(URL: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
            
            let path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            var outputUrl = path.objectAtIndex(0) as! String
            let manager = NSFileManager.defaultManager()
            
            do {
                try manager.createDirectoryAtPath(outputUrl, withIntermediateDirectories: true, attributes: nil)
            }catch{
                
            }
            
            outputUrl = outputUrl.convert.stringByAppendingString("output.mp4")
            
            do{
                try manager.removeItemAtPath(outputUrl)
            }catch{
                
            }
            
            if let exportSession = exportSession as AVAssetExportSession?{
                
                exportSession.outputURL = NSURL(fileURLWithPath: outputUrl)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileTypeMPEG4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronouslyWithCompletionHandler({ () -> Void in
                    
                    switch exportSession.status{
                        
                    case AVAssetExportSessionStatus.Completed:
                        completion?(videoPath: exportSession.outputURL, error: nil)
                    case AVAssetExportSessionStatus.Failed:
                        print("Failed: \(exportSession.error)")
                    case AVAssetExportSessionStatus.Cancelled:
                        print("Failed: \(exportSession.error)")
                    default:
                        print("default case")

                    }
                })
            }
//            dispatch_async(dispatch_get_main_queue()) {
//                
//            }
        }

    }
}

extension String{
    
    var convert: NSString {
        
        return(self as String)
    }
}
