//
//  ImagePickerProtocol.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/22.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol ImagePickerProtocol : class , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func chooseImage(image: UIImage)
    func chooseSourceType(type: Int, imagePicker: UIImagePickerController)
}

extension ImagePickerProtocol where Self : UIViewController {
    
    func chooseSourceType(type: Int, imagePicker: UIImagePickerController) {
        if type == 0 {
            imagePicker.sourceType = .PhotoLibrary
        } else if type == 1 {
            imagePicker.sourceType = .Camera
        }
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        chooseImage(image)
    }
    
}
