//
//  ActivitySectionViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/16.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ActivitySectionViewController: UIViewController {

    private var city: String = "全国"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor ( red: 0.1922, green: 0.2941, blue: 0.3137, alpha: 1.0 )
        automaticallyAdjustsScrollViewInsets = false

        setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        
        navigationController?.navigationBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "活动列表"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftButton = UIBarButtonItem(title: "全国", style: .Done, target: self, action: #selector(ActivitySectionViewController.chooseCity))
        leftButton.title = city
        navigationItem.leftBarButtonItem = leftButton
    }

    @objc private func chooseCity() {
        let cityVc = ActivityChooseCityViewController(chooseCity: city)
        cityVc.delegate = self
        presentViewController(cityVc, animated: true, completion: nil)
    }
    
}

extension ActivitySectionViewController : ActivityChooseCityViewControllerDelegate {
    
    func takeChooseCity(chooseCity: String) {
        city = chooseCity
        print("\(#function):: city = \(chooseCity)")
    }
    
}

