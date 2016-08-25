//
//  PlayTvViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/10.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import AVFoundation

class PlayTvViewController: UIViewController {

    
    private let closeButton: UIButton = UIButton()
    private var playId: String = ""
    private var barrages: [VideosBarrages] = []
    private var playTv = PlayTv()
//    private var subtitles: SubtitlesView!
    private var bottomView: BottomView!
    
    init(playId: String, barrages: [VideosBarrages]) {
        self.playId = playId
        self.barrages = barrages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0 )
        addSubViews()
//        playTv = PlayTv(frame: CGRect(x: 0, y: 100, width: view.bounds.size.width, height: view.bounds.size.height / 3))
//        playTv = PlayTv()
        view.addSubview(playTv)
        playTv.startPlay(playId)
        
        var infoArray: [String] = []
        barrages.forEach({
            infoArray.append($0.content)
        })
        
//        subtitles = SubtitlesView(frame: CGRect(x:0,y:view.bounds.size.height / 3 + 100,width:view.bounds.size.width,height: view.bounds.size.height / 3), infoStrArray: infoArray)
//        view.addSubview(subtitles)
//        subtitles.startSubtitles()

        bottomView = BottomView(frame: CGRect(x: 0, y: view.bounds.size.height - 60, width: view.bounds.size.width, height: 60))
        view.addSubview(bottomView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        playTv.dismiss()
//        subtitles.stopSubtitles()
//        subtitles.hidden = true
//        subtitles.removeFromSuperview()
        navigationController?.navigationBar.hidden = false
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    private func addSubViews() {
        closeButton.frame = CGRect(x: view.bounds.size.width - 50, y: 0, width: 30, height: 40)
        view.addSubview(closeButton)
        closeButton.setTitle("X", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.backgroundColor = UIColor ( red: 0.2431, green: 0.302, blue: 0.3059, alpha: 1.0 )
        closeButton.addTarget(self, action: #selector(PlayTvViewController.tapCloseButton), forControlEvents: .TouchUpInside)
        let maskPath = UIBezierPath(roundedRect: closeButton.bounds, byRoundingCorners: [.BottomLeft,.BottomRight], cornerRadii: CGSize(width: closeButton.bounds.size.width / 2, height: closeButton.bounds.size.width / 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = closeButton.bounds
        maskLayer.path = maskPath.CGPath
        closeButton.layer.mask = maskLayer
    }
    
    @objc private func tapCloseButton() {
        print("\(#function)")
        navigationController?.popViewControllerAnimated(true)
    }
    
}
