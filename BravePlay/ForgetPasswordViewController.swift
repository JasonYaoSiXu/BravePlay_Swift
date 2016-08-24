//
//  ForgetPasswordViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/19.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okBu: UIButton!
    @IBOutlet weak var checkCodeButton: UIButton!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var midLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var checkCodeTextField: UITextField!
    
    private var times : Int = 0
    private var countDownTime: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        initLine()
        initTextSubviews()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    private func initButton() {
        backButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        backButton.alpha = 1.0
        
        closeButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        closeButton.alpha = 1.0
        
        okBu.alpha = 1.0
        okBu.layer.cornerRadius = okBu.bounds.size.height / 2
        okBu.layer.masksToBounds = true
        okBu.layer.borderWidth = 1
        okBu.enabled = false
        okBu.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)
        okBu.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Disabled)
        okBu.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        
        checkCodeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        checkCodeButton.alpha = 1.0
        checkCodeButton.layer.cornerRadius = checkCodeButton.bounds.size.height / 2
        checkCodeButton.layer.masksToBounds = true
        checkCodeButton.layer.borderWidth = 1
        checkCodeButton.layer.borderColor = UIColor.whiteColor().CGColor
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
        phoneNumberTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "手机号", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        phoneNumberTextField.textColor = UIColor.whiteColor()
        phoneNumberTextField.alpha = 1.0
        
        checkCodeTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        checkCodeTextField.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        checkCodeTextField.textColor = UIColor.whiteColor()
        checkCodeTextField.alpha = 1.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ForgetPasswordViewController.oKButtonIsUser), name: UITextFieldTextDidChangeNotification, object: nil)
    }

    @IBAction func tapBackButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tapCloseButton(sender: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)
        dismissLogVc()
    }
    
    @IBAction func checkCodeButton(sender: UIButton) {
        checkCodeButton.enabled = false
        checkCodeButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        times = 50
        countDownTime = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ForgetPasswordViewController.cutDown), userInfo: nil, repeats: true)
        countDownTime.fire()
        forgetPasswordCheckCode()
    }
    
    @objc private func cutDown() {
        checkCodeButton.titleLabel?.text = "\(times)s后重发"
        checkCodeButton.setTitle("\(times)s后重发", forState: .Disabled)
        if times == 0 {
            countDownTime.invalidate()
            checkCodeButton.enabled = true
            checkCodeButton.layer.borderColor = UIColor.whiteColor().CGColor
        }
        times -= 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TransData" {
            guard let vc = segue.destinationViewController as? ResetPasswordViewController else {
                return
            }
            vc.phoneNumber = phoneNumberTextField.text!
            vc.checkCode = checkCodeTextField.text!
        }
    }
    
    @objc private func oKButtonIsUser() {
        if phoneNumberTextField.text?.characters.count > 0 && checkCodeTextField.text?.characters.count > 0 {
            if okBu.state != .Normal {
                okBu.enabled = true
                okBu.layer.borderColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
            }
        } else {
            if okBu.state == .Normal {
                okBu.enabled = false
                okBu.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
            }
        }
    }
}

extension ForgetPasswordViewController {
    
    //忘记密码获取验证码
    private func forgetPasswordCheckCode() {
        storySectionProvider.request(StorySection.ForgetPassword(phone_number: phoneNumberTextField.text!), completion: { [unowned self] result in
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
                        
                    }
                    return
                }
                self.showInfoMessage("成功获取验证码")
            case .Failure:
                self.popHud()
            }
            })
    }
}

