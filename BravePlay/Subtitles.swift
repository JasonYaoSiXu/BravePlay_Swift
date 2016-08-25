//
//  Subtitles.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/11.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit


class SubtitlesView: UIView {
    
    private var infoStrArray: [String] = []
    private var nsTime: NSTimer = NSTimer()
    private var closeTime: NSTimer = NSTimer()
    private var intoLabelArray: [UILabel] = []
    private var isInclude: Int = 0
    
    init(frame: CGRect, infoStrArray:[String] = [] ) {
        super.init(frame: frame)
        self.infoStrArray = infoStrArray
        backgroundColor = UIColor.blackColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSubtitles() {
        nsTime = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SubtitlesView.makeLabel), userInfo: nil, repeats: true)
    }
    
    func stopSubtitles() {
        isInclude = -1
        intoLabelArray.forEach({
            $0.removeFromSuperview()
        })
        nsTime.invalidate()
//        closeTime = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(SubtitlesView.clooseTimes), userInfo: nil, repeats: true)
    }
    
    @objc private func clooseTimes() {
        var isRemoveAll: Bool = false
        
        intoLabelArray.forEach({
            if $0.frame.origin.x == -($0.bounds.size.width) && $0.text == nil {
                isRemoveAll = true
                $0.removeFromSuperview()
            } else {
                isRemoveAll = false
                return
            }
        })
        
        if isRemoveAll {
            nsTime.invalidate()
            closeTime.invalidate()
        }
    }
    
    @objc private func makeLabel() {
        print("SubtitlesView ------->\(#function)")
        if  infoStrArray.count <= 0 {
            return
        }
        
        var label: UILabel?

        if isInclude == -1 {
            return
        }
        
        if isInclude != -1 {
            intoLabelArray.forEach({
                if $0.frame.origin.x == -($0.bounds.size.width) && $0.text == nil {
                    label = $0
                    isInclude == 1
                    return
                } else {
                    isInclude == 0
                }
            })
        }
        
        if isInclude == 0 {
            let height: CGFloat = 22
            let infoLabel :UILabel = UILabel()
            let numberRoad: Int = Int(bounds.size.height / height)
            let witchRoad: Int = Int(arc4random()) % numberRoad
            infoLabel.frame.origin = CGPoint(x: bounds.size.width, y: CGFloat(witchRoad) * height + 10)
            infoLabel.frame.size.height = height
            infoLabel.backgroundColor = UIColor.clearColor()
            infoLabel.textColor = UIColor.whiteColor()
            label = infoLabel
            if label != nil {
                addSubview(label!)
            }
        }
        
        if label == nil {
            return
        }
        
        let index: Int = Int(arc4random()) % infoStrArray.count
        label!.text = infoStrArray[index]
        label!.frame.origin.x = bounds.size.width
        label!.sizeToFit()
    
        var times: Double = 5
        if label!.text!.characters.count > 10 {
            times = 3
        }
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            UIView.animateWithDuration(times, animations: { _ in
                label!.frame.origin.x = -(label!.bounds.size.width)
                }, completion: { [unowned self] _ in
                    label!.text = nil
                    if !self.intoLabelArray.contains(label!) {
                        self.intoLabelArray.append(label!)
                    }
                })
//        })
    }
    
}