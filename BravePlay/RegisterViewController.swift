//
//  RegisterViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/19.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var getCheckCodeButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var firstLine: UIView!
    @IBOutlet weak var secondLine: UIView!
    @IBOutlet weak var midLine: UIView!
    @IBOutlet weak var thirdLine: UIView!
    @IBOutlet weak var lastLine: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var checkCodeTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var countDownTime: NSTimer = NSTimer()
    private var times: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
        initLine()
        initTextSubviews()
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

        registerButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Normal)
        registerButton.alpha = 1.0
        registerButton.layer.cornerRadius =  showButton.bounds.size.height / 2
        registerButton.layer.masksToBounds = true
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        registerButton.enabled = false
        registerButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Disabled)
        registerButton.setTitleColor(UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ), forState: .Normal)

        getCheckCodeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        getCheckCodeButton.alpha = 1.0
        getCheckCodeButton.layer.cornerRadius =  getCheckCodeButton.bounds.size.height / 2
        getCheckCodeButton.layer.masksToBounds = true
        getCheckCodeButton.layer.borderWidth = 1
        getCheckCodeButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        getCheckCodeButton.setTitleColor(UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ), forState: .Disabled)
        getCheckCodeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        showButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        showButton.alpha = 1.0
    }
    
    private func initLine() {
        firstLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        firstLine.alpha = 1.0
        
        secondLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        secondLine.alpha = 1.0

        midLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        midLine.alpha = 1.0

        thirdLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        thirdLine.alpha = 1.0

        lastLine.backgroundColor = UIColor ( red: 0.3608, green: 0.3647, blue: 0.3725, alpha: 1.0 )
        lastLine.alpha = 1.0
    }
    
    private func initTextSubviews() {
        detailLabel.textColor = UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )
        detailLabel.alpha = 1.0
        
        nickTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        nickTextField.attributedPlaceholder = NSAttributedString(string: "昵称", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        nickTextField.textColor = UIColor.whiteColor()
        nickTextField.alpha = 1.0
        nickTextField.clearButtonMode = .WhileEditing
        
        phoneTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "手机号码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        phoneTextField.textColor = UIColor.whiteColor()
        phoneTextField.alpha = 1.0
        phoneTextField.keyboardType = .NumberPad
        phoneTextField.clearButtonMode = .WhileEditing

        checkCodeTextFiled.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        checkCodeTextFiled.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        checkCodeTextFiled.textColor = UIColor.whiteColor()
        checkCodeTextFiled.alpha = 1.0
        checkCodeTextFiled.keyboardType = .NumberPad
        checkCodeTextFiled.clearButtonMode = .WhileEditing

        passwordTextField.tintColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 )
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "密码", attributes: [NSForegroundColorAttributeName : UIColor ( red: 0.4039, green: 0.4039, blue: 0.4118, alpha: 1.0 )])
        passwordTextField.textColor = UIColor.whiteColor()
        passwordTextField.secureTextEntry = true
        passwordTextField.alpha = 1.0
        passwordTextField.clearButtonMode = .WhileEditing
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.registerButtonIsUser), name: UITextFieldTextDidChangeNotification, object: nil)
        
    }
    
    @IBAction func tapBackButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(false, completion: {  _ in
            dismissLogVc()
        })
    }
    
    @IBAction func tapRegisterButton(sender: UIButton) {
        registerNewUser()
    }
    
    @IBAction func tapGetCheckCodeButtonn(sender: UIButton) {
        getCheckCodeButton.enabled = false
        getCheckCodeButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        times = 50
        countDownTime = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(RegisterViewController.cutDown), userInfo: nil, repeats: true)
        countDownTime.fire()
        
        if phoneTextField.text?.characters.count == 0 {
            showErrorMessage("手机号码不能为空!")
            return
        }
        registerCheckCode()

    }
    
    @objc private func cutDown() {
        getCheckCodeButton.titleLabel?.text = "\(times)s后重发"
        getCheckCodeButton.setTitle("\(times)s后重发", forState: .Disabled)
        if times == 0 {
            countDownTime.invalidate()
            getCheckCodeButton.enabled = true
            getCheckCodeButton.layer.borderColor = UIColor.whiteColor().CGColor
        }
        times -= 1
    }

    @IBAction func tapShowButton(sender: UIButton) {
        passwordTextField.secureTextEntry = !passwordTextField.secureTextEntry
        
        if passwordTextField.secureTextEntry == false {
            showButton.setTitle("隐藏", forState: .Normal)
        } else {
            showButton.setTitle("显示", forState: .Normal)
        }
        
    }
    
    @objc private func registerButtonIsUser() {
        print("\(#function) :: = \(nickTextField.text)")
        if nickTextField.text?.characters.count > 0 && phoneTextField.text?.characters.count > 0 && checkCodeTextFiled.text?.characters.count > 0 && passwordTextField.text?.characters.count > 0 {
            registerButton.enabled = true
            registerButton.layer.borderColor = UIColor ( red: 0.9569, green: 0.6118, blue: 0.051, alpha: 1.0 ).CGColor
        } else {
            if registerButton.state == .Normal {
                registerButton.enabled = false
            }
            registerButton.layer.borderColor = UIColor ( red: 0.6549, green: 0.6549, blue: 0.6667, alpha: 1.0 ).CGColor
        }
    }
    
}

//请求数据
extension RegisterViewController {
    
    //获取注册验证码
    private func registerCheckCode() {
        storySectionProvider.request(StorySection.RegisterGetCheckCode(phone_number: phoneTextField.text!), completion: { [unowned self] result in
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
                do {
                    let json = try results.mapJSON()
                    guard let data = Mapper<RegisterCheckCode>().map(json) else {
                        return
                    }
                    print("data = \(data)")
                } catch {
                    self.popHud()
                }
            case .Failure:
                self.popHud()
            }
        })
    }
    
    //注册新账号
    private func registerNewUser() {
        storySectionProvider.request(StorySection.Register(nickname: nickTextField.text!, password: passwordTextField.text!, phone_number: phoneTextField.text!, verify_code: checkCodeTextFiled.text!), completion: { [unowned self] result in
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
                self.LogIn()
//                do {
//                    let json = try results.mapJSON()
//                    guard let data = Mapper<RegisterCheckCode>().map(json) else {
//                        return
//                    }
//                    print("data = \(data)")
//                } catch {
//                    self.popHud()
//                }
            case .Failure:
                self.popHud()
            }
            })
    }
    
    private func LogIn() {
        mineSectionProvider.request(MineSection.Sessions(password: passwordTextField.text!, phoneNumber: phoneTextField.text!), completion: { [unowned self] result in
            switch result {
            case .Success(let results):
                print("status = \(results.statusCode)")
                if results.statusCode != 200 {
                    self.dealWithError(MyErrorType.ResultErrorCode(code: results.statusCode))
                    return
                }
                do {
                    let json = try results.mapJSON()
                    guard let data = Mapper<UserLogIn>().map(json) else {
                        return
                    }
                    print("data = \(data)")
                } catch {
                    self.popHud()
                }
            case .Failure:
                self.popHud()
            }
            })
    }
    
}

