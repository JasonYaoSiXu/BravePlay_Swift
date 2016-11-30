//
//  PlayTv.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/10.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class PlayTv : UIView {
    private var avPlayer: AVPlayer! = AVPlayer()
    private var playItem: AVPlayerItem!
    private var playerLayer: AVPlayerLayer! = AVPlayerLayer()
    private var isShow: Bool = true
    private var isPlay: Bool = true
    private var isPlayEnd: Bool = false
    private var isFullScreen: Bool = false
    private let controlView = UIView()
    private var currTimes: Double = 0
    private var selfFrame: CGRect = CGRectZero
    
    private let playTimeLabel: UILabel = UILabel()
    private let sumTimesLabel: UILabel = UILabel()
    private let loadProgress: UIProgressView = UIProgressView()
    private let playSlider: UISlider = UISlider()
    private let playButton: UIButton = UIButton()
    private let fullScreenButton: UIButton = UIButton()
    private let loadAnimationActivity: UIActivityIndicatorView = UIActivityIndicatorView()
    private var timeObject: AnyObject!
    
    deinit {
        print("Play Tv Deinit")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapSelf = UITapGestureRecognizer(target: self, action: #selector(PlayTv.tapSelf))
        self.addGestureRecognizer(tapSelf)
        configVideoPlayer()
        controlerBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 添加播放试图
    private func configVideoPlayer() {
        avPlayer = AVPlayer()
        playerLayer = AVPlayerLayer(player: avPlayer)
        playerLayer.backgroundColor = UIColor.blackColor().CGColor
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        selfFrame = frame
        playerLayer.frame = bounds
        layer.addSublayer(playerLayer)
        
        let height: CGFloat = 30
        let width: CGFloat = 30
        loadAnimationActivity.frame = CGRect(x: (bounds.size.width - width) / 2, y: (bounds.size.height - height) / 2 , width: width, height: height)
        addSubview(loadAnimationActivity)
    }
    
    func startPlay(url: String) {
        print("\(#function)")
        guard let video = NSURL(string: url) else {
            return
        }
        
        playItem = AVPlayerItem(URL: video)
        avPlayer = AVPlayer(playerItem: playItem)
        playerLayer.player = avPlayer
        start()
    }
    
    private func start() {
        print("\(#function)")
        playItem.addObserver(self, forKeyPath: "status", options: .New, context: nil)
        playItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: .New, context: nil)
        playItem.addObserver(self, forKeyPath: "duration", options: .New, context: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayTv.playEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        avPlayer.play()
        loadAnimationActivity.startAnimating()
    }
    
    //播放结束
    @objc private func playEnd() {
        print("\(#function)")
        isPlayEnd = true
        playItem.removeObserver(self, forKeyPath: "status")
        playItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playItem.removeObserver(self, forKeyPath: "duration")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //退出播放界面
    func dismiss() {
        print("\(#function)")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { [unowned self] _ in
            self.avPlayer.pause()
            if self.isPlayEnd == false {
                self.playEnd()
            }
            self.avPlayer.removeTimeObserver(self.timeObject)
            self.playItem = nil
            self.avPlayer = nil
            self.playerLayer = nil
            self.hidden = true
        })
    }
    
    // kvo 监听播放状态
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if isPlayEnd == true {
            return
        }
        guard let avPlayItem = object as? AVPlayerItem else {
            return
        }
        
        if keyPath == "status" {
            switch avPlayItem.status {
            case .Failed:
                print("\(#function)::play Failed")
                avPlayer.pause()
                loadAnimationActivity.stopAnimating()
            case .ReadyToPlay:
                print("\(#function)::ReadyToPlay")
                timeObject = avPlayer.addPeriodicTimeObserverForInterval(CMTime(seconds: 1, preferredTimescale: 1), queue: nil, usingBlock: { [unowned self] _ in
                    self.cucalatePlay()
                })
            case .Unknown:
                print("\(#function)::Unknown Error")
            }
        } else if keyPath == "loadedTimeRanges" {
            print("loadedTimeRanges")
            cucalateLoad()
        } else if keyPath == "duration" {
            print("\(#function)::duration")
            let times = avPlayItem.duration.seconds
            print("times = \(times)")
            sumTimesLabel.text = fromNumberToTime(times)
        }
        
    }
    
    //计算播放时间
    private func cucalatePlay() {
        print("\(#function)")
        if loadAnimationActivity.isAnimating() {
            loadAnimationActivity.stopAnimating()
        }
        playTimeLabel.text = fromNumberToTime(playItem.currentTime().seconds)
        playSlider.value = Float(playItem.currentTime().seconds / playItem.duration.seconds)
    }
    
    // 计算缓冲
    private func cucalateLoad() {
        print("\(#function)")
        let timeRange = playItem.loadedTimeRanges
        guard let loadTimeRange = timeRange.first?.CMTimeRangeValue else {
            return
        }
        let startTime = CMTimeGetSeconds(loadTimeRange.start)
        let durationTime = CMTimeGetSeconds(loadTimeRange.duration)
        
        if   (startTime + durationTime) - playItem.currentTime().seconds <=  5 && loadAnimationActivity.isAnimating() == false {
            avPlayer.pause()
            loadAnimationActivity.startAnimating()
        } else if (startTime + durationTime) - playItem.currentTime().seconds >  5 && loadAnimationActivity.isAnimating()  || (startTime + durationTime) == playItem.duration.seconds {
            avPlayer.play()
            loadAnimationActivity.stopAnimating()
        }
        
        loadProgress.setProgress(Float( Double(startTime + durationTime) / (playItem.duration.seconds)), animated: true)
    }
    
    //把返回的时间格式化
    private func fromNumberToTime(number: Double) -> String {
        let date = NSDate(timeIntervalSince1970: number)
        let dateFormat = NSDateFormatter()
        
        if number >= 3600 {
            dateFormat.dateFormat = "HH:mm:ss"
        } else {
            dateFormat.dateFormat = "mm:ss"
        }
        
        return dateFormat.stringFromDate(date)
    }
}

//点击事件
extension  PlayTv {
    // 点击播放界面隐藏显示播放控制条
    @objc private func tapSelf() {
        UIView.animateWithDuration(1, animations: { [unowned self] in
            if self.isShow {
                self.controlView.alpha = 0.0
            } else {
                self.controlView.alpha = 0.6
            }
        })
        isShow = !isShow
    }
    
    //拖动slider
    @objc private func dragSlider() {
        print("\(#function)")
        let value = Double(playSlider.value)
        playItem.seekToTime(CMTime(seconds: playItem.duration.seconds * value, preferredTimescale: 1))
        loadAnimationActivity.startAnimating()
    }

    //点击全屏按钮
    @objc private func tapFullScreenButton() {
        print("\(#function)")
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        controlView.hidden = true
        UIView.animateWithDuration(0.25, animations: { [unowned self] _ in
            if self.isFullScreen {
                self.fullScreenButton.setTitle("退出", forState: .Normal)
                self.center = CGPoint(x:width / 2,y:height / 2)
                self.frame = CGRect(x:-(height - width) / 2,y:(height - width) / 2,width:height,height:width)
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            } else {
                self.fullScreenButton.setTitle("全屏", forState: .Normal)
                self.transform = CGAffineTransformMakeRotation(CGFloat(0))
                self.frame = self.selfFrame
            }
            }, completion: { [unowned self] _ in
                self.playerLayer.frame = self.bounds
                self.controlView.hidden = false
                self.isFullScreen = !self.isFullScreen
        })
    }

    //点击播放按钮
    @objc private func tapPlayButton() {
        print("\(#function)")
        isPlay = !isPlay
        if isPlay {
            avPlayer?.play()
            playButton.setImage(UIImage(named: "停止"), forState: .Normal)
            playItem.seekToTime(CMTime(seconds: currTimes, preferredTimescale: 1))
        } else {
            avPlayer?.pause()
            playButton.setImage(UIImage(named: "播放"), forState: .Normal)
            currTimes = playItem.currentTime().seconds
        }
    }
}

//添加播放控制条
extension PlayTv {
        //添加播放控制条
        private func controlerBar() {
            addSubview(controlView)
            controlView.backgroundColor = UIColor ( red: 0.0, green: 0.2706, blue: 0.6078, alpha: 1.0 )
            controlView.alpha = 0.6
    
            controlView.snp.makeConstraints(closure: { [unowned self] make in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.height.equalTo(self.bounds.size.height / 5)
                make.bottom.equalTo(self.snp.bottom)
                })
            addSubviewForControlView()
        }
    
        //为播放控制条添加子控件
        private func addSubviewForControlView() {
            //缓冲进度条
            controlView.addSubview(loadProgress)
            loadProgress.progressTintColor = UIColor ( red: 0.9843, green: 0.7882, blue: 0.1843, alpha: 1.0 )
            loadProgress.trackTintColor = UIColor.grayColor()
            loadProgress.snp.makeConstraints(closure: { [unowned self] make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(90)
                make.right.equalTo(-90)
                make.height.equalTo(3)
                })
    
            //播放进度条
            controlView.addSubview(playSlider)
            playSlider.minimumTrackTintColor = UIColor.clearColor()
            playSlider.maximumTrackTintColor = UIColor.clearColor()
            playSlider.minimumValueImageRectForBounds(loadProgress.bounds)
            playSlider.value = 0
            playSlider.snp.makeConstraints(closure: { make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(90)
                make.right.equalTo(-90)
                make.height.equalTo(3)
            })
            playSlider.addTarget(self, action: #selector(PlayTv.dragSlider), forControlEvents: .TouchDragInside)
    
            //停止播放按钮
            controlView.addSubview(playButton)
            playButton.setImage(UIImage(named: "停止"), forState: .Normal)
            playButton.addTarget(self, action: #selector(PlayTv.tapPlayButton), forControlEvents: .TouchUpInside)
            playButton.snp.makeConstraints(closure: { [unowned self] make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(10)
                make.width.equalTo(20)
                make.height.equalTo(20)
                })
    
            //已经播放的时间
            controlView.addSubview(playTimeLabel)
            playTimeLabel.textColor = UIColor.whiteColor()
            playTimeLabel.text = "00:00"
            playTimeLabel.font = UIFont(name: "Helvetica", size: 14)
            playTimeLabel.snp.makeConstraints(closure: { [unowned self] make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(self.playButton.snp.right).offset(10)
                })
    
            //总时间
            controlView.addSubview(sumTimesLabel)
            sumTimesLabel.textColor = UIColor.whiteColor()
            sumTimesLabel.text = "00:00"
            sumTimesLabel.font = UIFont(name: "Helvetica", size: 14)
            sumTimesLabel.snp.makeConstraints(closure: { [unowned self] make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(self.loadProgress.snp.right).offset(10)
                })
    
            //全屏按钮
            controlView.addSubview(fullScreenButton)
            fullScreenButton.setTitle("全屏", forState: .Normal)
            fullScreenButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            fullScreenButton.addTarget(self, action: #selector(PlayTv.tapFullScreenButton), forControlEvents: .TouchUpInside)
            fullScreenButton.snp.makeConstraints(closure: { [unowned self] make in
                make.centerY.equalTo(self.controlView.snp.centerY)
                make.left.equalTo(self.sumTimesLabel.snp.right).offset(5)
                make.height.equalTo(20)
                })
        }
}