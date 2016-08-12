//
//  numberOfTicketsView.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/9.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import SnapKit

protocol NumberOfTicketsViewDelegate:class {
    func ticketNumbers(numbers: Int)
}

class NumberOfTicketsView: UIView {
    
    private let subButton = UIButton()
    private let addButton = UIButton()
    private let numberLabel = UILabel()
    weak var delegate: NumberOfTicketsViewDelegate!
    
    var ticketNumbers: Int = 1 {
        didSet {
            numberLabel.text = "\(ticketNumbers)"
            delegate.ticketNumbers(ticketNumbers)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let subViewWidth = self.frame.size.width / 4
        
        self.addSubview(subButton)
        self.addSubview(numberLabel)
        self.addSubview(addButton)
        
        subButton.snp.makeConstraints(closure: { [unowned self] make in
            make.left.equalTo(subViewWidth / 2)
            make.top.equalTo((self.frame.size.height - subViewWidth) / 2)
            make.width.equalTo(subViewWidth)
            make.height.equalTo(subViewWidth)
        })
        subButton.layer.cornerRadius = 4
        subButton.layer.masksToBounds = true
        subButton.layer.borderWidth = 1
        subButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        numberLabel.snp.makeConstraints(closure: { make in
            make.top.equalTo((self.frame.size.height - subViewWidth) / 2)
            make.left.equalTo(subButton.snp.right)
            make.width.equalTo(subViewWidth)
            make.height.equalTo(subViewWidth)
        })
//        numberLabel.layer.borderWidth = 1
//        numberLabel.layer.borderColor = UIColor.whiteColor().CGColor
        
        addButton.snp.makeConstraints(closure: { make in
            make.left.equalTo(numberLabel.snp.right)
            make.top.equalTo((self.frame.size.height - subViewWidth) / 2)
            make.width.equalTo(subViewWidth)
            make.height.equalTo(subViewWidth)
        })
        addButton.layer.cornerRadius = 4
        addButton.layer.masksToBounds = true
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        numberLabel.textAlignment = .Center
        numberLabel.textColor = UIColor ( red: 0.902, green: 0.5294, blue: 0.0471, alpha: 1.0 )
        numberLabel.text = "\(ticketNumbers)"
        
        subButton.addTarget(self, action: #selector(NumberOfTicketsView.tapSubButton), forControlEvents: .TouchUpInside)
        subButton.setTitle("-", forState: .Normal)
        subButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.addTarget(self, action: #selector(NumberOfTicketsView.tapAddButton), forControlEvents: .TouchUpInside)
        addButton.setTitle("+", forState: .Normal)
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        let topLine = UIView()
        let bottomLine = UIView()
        addSubview(topLine)
        addSubview(bottomLine)
        topLine.backgroundColor = UIColor.whiteColor()
        bottomLine.backgroundColor = UIColor.whiteColor()
        
        topLine.snp.makeConstraints(closure: { make in
            make.top.equalTo((self.frame.size.height - subViewWidth) / 2)
            make.left.equalTo(subButton.snp.right)
            make.width.equalTo(subViewWidth + 4)
            make.height.equalTo(1)
        })
        
        bottomLine.snp.makeConstraints(closure: { make in
            make.top.equalTo(subViewWidth * 1.25 - 1)
            make.left.equalTo(subButton.snp.right)
            make.width.equalTo(subViewWidth + 1)
            make.height.equalTo(1)
        })

    }
    
    @objc private func tapSubButton() {
        print("\(#function)")
        if ticketNumbers > 1 {
            ticketNumbers -= 1
        }
    }
    
    @objc private func tapAddButton() {
        print("\(#function)")
        ticketNumbers += 1
    }
    
}
