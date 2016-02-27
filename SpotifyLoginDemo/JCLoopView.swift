//
//  JCLoopView.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/27.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class JCLoopView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK:properties
    private var titleArray: [String]?
    
    private var cycleTimer :NSTimer?
    
    //MARK:life cycle
    init(titleArray: [String]){
        
        super.init(frame: CGRectZero, collectionViewLayout: LoopViewLayout())
        
        self.titleArray = titleArray
        self.delegate = self
        self.dataSource = self
        
        self.registerClass(LoopViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if self.titleArray?.count > 1 {
                
                let index = NSIndexPath(forItem: (self.titleArray?.count)!, inSection: 0)
                
                self.scrollToItemAtIndexPath(index, atScrollPosition: .Right, animated: false)
            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    private func timeStart(){
//        
//        let timer = NSTimer(timeInterval: 2, target: self, selector: "next", userInfo: nil, repeats: true)
//        cycleTimer = timer
//        
//        let runloop = NSRunLoop.currentRunLoop()
//        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
//        
//    }
//    
//    func next(){
//        
//        let indexPath = PictureCycleView!
//            .indexPathsForVisibleItems().first!
//        
//        let item = indexPath.item
//        let section = indexPath.section
//        
//        
//        if item == titleArray.count - 1{
//            //最后一个item,跳到下一组
//            PictureCycleView!.selectItemAtIndexPath(NSIndexPath(forItem: 0 , inSection: section + 1), animated: true, scrollPosition: UICollectionViewScrollPosition.Right)
//        }
//        else{
//            //下一个item
//            PictureCycleView?.selectItemAtIndexPath(NSIndexPath(forItem: item + 1, inSection: section), animated: true, scrollPosition: .Right)
//        }
//    }

    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return titleArray!.count * (titleArray!.count == 1 ? 1 : 100)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LoopViewCell
    
        let model = titleArray![indexPath.item % titleArray!.count]
        
        cell.titleText = model
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        var offset: NSInteger = NSInteger(scrollView.contentOffset.x / scrollView.bounds.size.width)
        
        if offset == 0 || offset == (self.numberOfItemsInSection(0) - 1){
            
            
            offset = self.titleArray!.count - (offset == 0 ? 0 : 1)
            
            scrollView.contentOffset = CGPointMake(CGFloat(offset) * scrollView.bounds.size.width, 0)
        }
    }

    
}

//MARK:LoopViewLayout
class LoopViewLayout: UICollectionViewFlowLayout{
    
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = self.collectionView!.bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        self.collectionView!.showsHorizontalScrollIndicator = false
        self.collectionView!.showsVerticalScrollIndicator = false
        self.collectionView!.pagingEnabled = true
        self.collectionView?.backgroundColor = UIColor.clearColor()
        
    }
    
}



//MARK:LoopViewCell
class LoopViewCell: UICollectionViewCell{
    
    //MARK:properties
    var textLabel: UILabel?
    
    var titleText: String?{
        didSet{
            textLabel?.text = titleText
        }
    }
    
    //MARK:life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel()
        textLabel?.backgroundColor = UIColor.clearColor()
        textLabel?.textColor = UIColor.whiteColor()
        textLabel?.textAlignment = .Center
        textLabel?.numberOfLines = 0
        addSubview(textLabel!)
        
        textLabel?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1).offset(0)
            make.right.equalTo((textLabel?.superview?.snp_right)!).multipliedBy(1).offset(-10)
            make.left.equalTo((textLabel?.superview?.snp_left)!).multipliedBy(1).offset(10)
            make.height.equalTo(100)
            make.bottom.equalTo(self.snp_bottom).multipliedBy(1).offset(-200)
            
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

