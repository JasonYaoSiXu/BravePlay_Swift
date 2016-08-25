//
//  ViewControllerPushAnimation.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/25.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewControllerPushAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    //蒙板
    private var maskLayer = CAShapeLayer()
    //源路径
    private var originFrame: CGRect = CGRectZero
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width
    let height: CGFloat = UIScreen.mainScreen().bounds.size.height
    private var oppositeAnglesLength: CGFloat = 0
    
    private var transitionContext : UIViewControllerContextTransitioning!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
            return
        }
        
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
            return
        }
        
        transitionContext.containerView()?.insertSubview(toVC.view, aboveSubview: fromVC.view)
        self.transitionContext = transitionContext
        
        oppositeAnglesLength = sqrt(width * width + height * height)
        originFrame = CGRect(x: width, y: height, width: 1, height: 1)
        maskLayer.path = UIBezierPath(ovalInRect: originFrame).CGPath
        toVC.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = UIBezierPath(ovalInRect: originFrame).CGPath
        animation.toValue = UIBezierPath(ovalInRect: CGRectInset(originFrame, -oppositeAnglesLength, -oppositeAnglesLength)).CGPath
        animation.duration = 2.0
        animation.delegate = self
        maskLayer.addAnimation(animation, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        maskLayer.path = UIBezierPath(ovalInRect: CGRectInset(originFrame, -oppositeAnglesLength, -oppositeAnglesLength)).CGPath
        transitionContext.completeTransition(true)
    }
}