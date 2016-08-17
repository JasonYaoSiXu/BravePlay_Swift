//
//  MainPageViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/7/29.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class MainPageViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        tabBar.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        tabBar.barTintColor = UIColor( red: 0.0824, green: 0.1216, blue: 0.1412, alpha: 1.0 )
        
        addSubViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addSubViewController() {
        print("\(#function)")
        //首页
        var viewControllers = [UIViewController]()
        var vc : UIViewController = ViewController()
        var nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "首页"), selectedImage: UIImage(named: "首页-选中"))
        nvc.tabBarItem.tag = 0
        viewControllers.append(nvc)
        
        //趣闻
        vc = InterestingSectionViewController()
        nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "趣闻", image: UIImage(named: "购票"), selectedImage: UIImage(named: "购票-选中"))
        nvc.tabBarItem.tag = 1
        viewControllers.append(nvc)
        
        //TV
        vc = TVSectionViewController()
        nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "TV", image: UIImage(named: "发现"), selectedImage: UIImage(named: "发现-选中"))
        nvc.tabBarItem.tag = 2
        viewControllers.append(nvc)
        
        //活动列表
        vc = ActivitySectionViewController()
        nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "活动", image: UIImage(named: "购票"), selectedImage: UIImage(named: "购票-选中"))
        nvc.tabBarItem.tag = 3
        viewControllers.append(nvc)
        
        //活动列表
        vc = MineSectionViewController()
        nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "我的"), selectedImage: UIImage(named: "我的-选中"))
        nvc.tabBarItem.tag = 4
        viewControllers.append(nvc)
        
        self.viewControllers = viewControllers
    }
    
}
