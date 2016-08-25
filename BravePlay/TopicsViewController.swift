//
//  TopicsViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/24.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result

class TopicsViewController: UIViewController {

    private let cellIdentifier = "TopicsDataCollectionViewCell"
    private var collectionView: UICollectionView!
    private var channelData: [TopicsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false

        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "Topic精选"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        initCollectionView()
        requestTopicsData(1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    private func initCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.size.width / 2, height: 180)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 64,width: UIScreen.mainScreen().bounds.size.width,height: UIScreen.mainScreen().bounds.size.height - 64), collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = view.backgroundColor
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension TopicsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as? TopicsDataCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bgImageUrl = channelData[indexPath.row].recommend_background_image
        cell.typeLabel.text = channelData[indexPath.row].name
        cell.headImageUrl = channelData[indexPath.row].recommend_normal_image
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = UserVcViewController(userId: "\(channelData[indexPath.row].id)", userName: channelData[indexPath.row].name, isLast: true)
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TopicsViewController : MoyaPares {
    
    private func requestTopicsData(page: Int) {
        
        MainSectionProvider.request(MainSection.TopicsData(page: page), completion: { [unowned self] result in
            self.showHud("正在加载")
            let resultData : Result<[TopicsModel],MyErrorType> = self.paresObjectArray(result)
            switch resultData {
            case .Success(let data):
                self.popHud()
                self.channelData = data
                self.collectionView.reloadData()
            case .Failure(let error):
                self.dealWithError(error)
            }
        })
        
    }
    
}
