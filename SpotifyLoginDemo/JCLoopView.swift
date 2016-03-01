//
//  JCLoopView.swift
//  SpotifyLoginDemo
//
//  Created by chenjunpu on 16/2/27.
//  Copyright © 2016年 chenjunpu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class JCLoopView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK:properties
    private var loopView: UICollectionView?
    
    var titleArray: [String]?
    
    private var cycleTimer: NSTimer?
    
    lazy var pageVc: UIPageControl = UIPageControl()
    
    //MARK:life cycle
    init(titleArray: [String]){
        super.init(frame: CGRectZero)
        
        loopView = UICollectionView(frame: self.bounds, collectionViewLayout: LoopViewLayout())
        self.titleArray = titleArray
        loopView!.delegate = self
        loopView!.dataSource = self
        
        loopView!.registerClass(LoopViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(loopView!)
        addSubview(pageVc)

        pageVc.numberOfPages = (titleArray.count)
        pageVc.currentPageIndicatorTintColor = UIColor.whiteColor()
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if self.titleArray?.count > 1 {
                
                let index = NSIndexPath(forItem: (self.titleArray?.count)!, inSection: 0)
                
                self.loopView!.scrollToItemAtIndexPath(index, atScrollPosition: .Right, animated: false)
                
                self.timeStart()
                
            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loopView?.frame = self.frame
        
        pageVc.snp_makeConstraints(closure: { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).multipliedBy(1).offset(0)
            make.bottom.equalTo(self.snp_bottom).multipliedBy(1).offset(-170)


        })
        
    }
    
    //MARK:method
    private func timeStart(){
        
        let timer = NSTimer(timeInterval: 2, target: self, selector: "next", userInfo: nil, repeats: true)
        cycleTimer = timer
        
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
        
    }
    
    
    private func stopTimer(){
        cycleTimer?.invalidate()
        
        cycleTimer = nil
    }

    
    func next(){
        
        let indexPath  = loopView!.indexPathsForVisibleItems().first!
        
        let item = indexPath.item
        let section = indexPath.section
        
        loopView!.selectItemAtIndexPath(NSIndexPath(forItem: item + 1, inSection: section), animated: true, scrollPosition: .Right)

    }

    
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
        
        if offset == 0 || offset == (loopView!.numberOfItemsInSection(0) - 1){
            
            
            offset = self.titleArray!.count - (offset == 0 ? 0 : 1)
            
            scrollView.contentOffset = CGPointMake(CGFloat(offset) * scrollView.bounds.size.width, 0)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let ind = indexPath.item % titleArray!.count
        self.pageVc.currentPage = ind
    }

    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        
        timeStart()
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
    
    var pageVc: UIPageControl?
    
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

