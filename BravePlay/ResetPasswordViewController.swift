//
//  ResetPasswordViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/23.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import ObjectMapper

class ResetPasswordViewController: UIViewController {

    var phoneNumber : String = ""
    var checkCode: String = ""
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var OkButton: UIButton!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var midLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var firstPassword: UITextField!
    @IBOutlet weak var secondPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        initLine()
        initTextSubviews()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initButton() {
        backButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        backButton.alpha = 1.0
        
        closeButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        closeButton.alpha = 1.0
        
        OkButton.alpha = 1.0
        OkButton.layer.cornerRadius = OkButton.bounds.size.height / 2
        OkButton.layer.masksToBounds = true
        OkButton.layer.borderWidth = 1
        OkButton.enabled = false
        OkButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        OkButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Disabled)
        OkButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
    }
    
    private func initLine() {
        topLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        topLine.alpha = 1.0
        
        midLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        midLine.alpha = 1.0
        
        bottomLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        bottomLine.alpha = 1.0
    }
    
    private func initTextSubviews() {
        firstPassword.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        firstPassword.attributedPlaceholder = NSAttributedString(string: "输入新密码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        firstPassword.textColor = UIColor.whiteColor()
        firstPassword.alpha = 1.0
        firstPassword.secureTextEntry = true
        firstPassword.clearButtonMode = .WhileEditing
        
        secondPassword.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        secondPassword.attributedPlaceholder = NSAttributedString(string: "再次输入", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        secondPassword.textColor = UIColor.whiteColor()
        secondPassword.alpha = 1.0
        secondPassword.secureTextEntry = true
        secondPassword.clearButtonMode = .WhileEditing
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ResetPasswordViewController.oKButtonIsUser), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    @IBAction func tapCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(false, completion: nil)
        navigationController?.popToRootViewControllerAnimated(true)
        dismissLogVc()
    }
    
    @IBAction func tapBackButton(sender: UIButton) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func tapOkButton(sender: UIButton) {
        
        if firstPassword.text != secondPassword.text! {
            showErrorMessage("请保证两次输入的密码相同!")
            return
        }
        changePassword()
    }
    
    @objc private func oKButtonIsUser() {
        if firstPassword.text?.characters.count > 0 && secondPassword.text?.characters.count > 0 {
            if OkButton.state != .Normal {
                OkButton.enabled = true
                OkButton.layer.borderColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
            }
        } else {
            if OkButton.state == .Normal {
                OkButton.enabled = false
                OkButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
            }
        }
    }
}


extension ResetPasswordViewController {
    
    //修改密码
    private func changePassword() {
        storySectionProvider.request(StorySection.ChangePassword(password: firstPassword.text!, phone_number: phoneNumber, verify_code: checkCode), completion: { [unowned
            self] result in
            self.showHud("修改中...")
            switch result {
            case .Success(let results):
                print("status = \(results.statusCode)")
                if results.statusCode != 200 {
                    do {
                        let json = try results.mapJSON()
                        guard let data = Mapper<GetRegisterCheckCodeError>().mapArray(json) else {
                            return
                        }
                        self.showErrorMessage(data[0].message)
                    } catch {
                        self.showErrorMessage("出错")
                    }
                    return
                }
                self.showInfoMessage("成功修改密码")
                self.navigationController?.popToRootViewControllerAnimated(true)
            case .Failure:
                self.showErrorMessage("出错")
            }
            })
    }
}

