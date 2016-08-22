//
//  LogViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/19.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import Result
import ObjectMapper

class LogViewController: UIViewController,MoyaPares {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var forgetOasswordButton: UIButton!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var midLine: UIView!
    @IBOutlet weak var bottonLine: UIView!
    
    @IBOutlet weak var phoneNumberTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
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

        logButton.alpha = 1.0
        logButton.layer.cornerRadius = logButton.bounds.size.height / 2
        logButton.layer.masksToBounds = true
        logButton.layer.borderWidth = 1
        logButton.enabled = false
        logButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        logButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Disabled)
        logButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        
        forgetOasswordButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forgetOasswordButton.alpha = 1.0
    }
    
    private func initLine() {
        topLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        topLine.alpha = 1.0

        midLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        midLine.alpha = 1.0
        
        bottonLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        bottonLine.alpha = 1.0
    }
    
    private func initTextSubviews() {
        phoneNumberTextFiled.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        phoneNumberTextFiled.attributedPlaceholder = NSAttributedString(string: "手机号", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        phoneNumberTextFiled.textColor = UIColor.whiteColor()
        phoneNumberTextFiled.alpha = 1.0
        phoneNumberTextFiled.keyboardType = .NumbersAndPunctuation
        phoneNumberTextFiled.clearButtonMode = .WhileEditing
        
        passwordTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "密码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.secureTextEntry = true
        passwordTextField.alpha = 1.0
        passwordTextField.clearButtonMode = .WhileEditing
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LogViewController.logButtonIsUser), name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    @IBAction func tapBackButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tapCloseButton(sender: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)
        dismissLogVc()
    }
    
    @IBAction func tapLogButton(sender: UIButton) {
        showHud("正在登录")
        mineSectionProvider.request(MineSection.Sessions(password: passwordTextField.text!, phoneNumber: phoneNumberTextFiled.text!), completion: { [unowned self] result in
            switch result {
            case .Success(let results):
                print("status = \(results.statusCode)")
                do {
                    let json = try results.mapJSON()
                    guard let data = Mapper<UserLogIn>().map(json) else {
                        return
                    }
                    print("data = \(data)")
                    self.userData(data.access_token)
                } catch {
                    
                }
            case .Failure:
                self.popHud()
            }
        })
    }
    
    private func userData(userToken: String) {
        mineSectionProvider.request(MineSection.UserData(userToken: userToken), completion: { [unowned self] result in
            let resultData : Result<UserLogData,MyErrorType> = self.paresObject(result)

            switch resultData {
            case .Success(let data):
                UserData.UserDatas.userLogIn(data)
                self.navigationController?.popToRootViewControllerAnimated(true)
                dismissLogVc()
                self.showInfoMessage("登录成功")
            case .Failure(let error):
                self.popHud()
                self.dealWithError(error)
            }
        })
    }
    
    
    @objc private func logButtonIsUser() {
        if phoneNumberTextFiled.text?.characters.count > 0 && passwordTextField.text?.characters.count > 0 {
            if logButton.state != .Normal {
                logButton.enabled = true
                logButton.layer.borderColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
            }
        } else {
            if logButton.state == .Normal {
                logButton.enabled = false
                logButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
            }
        }
    }
    
}
