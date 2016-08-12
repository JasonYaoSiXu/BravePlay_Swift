//
//  MapVCViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import CoreLocation

class MapVCViewController: UIViewController {

    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCode() {
        let address: String = "123"
        geocoder.geocodeAddressString(address, completionHandler: {
            if $0.0?.count == 0 {
                self.showInfoMessage("不能翻转")
            } else {
                let object = $0.0?.first
                let detailName = object!.name
                
                let lat = object?.location?.coordinate.latitude
                let log = object?.location?.coordinate.longitude
            }
        })
    }
    
}
