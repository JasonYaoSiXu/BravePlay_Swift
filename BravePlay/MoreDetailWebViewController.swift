//
//  MoreDetailWebViewController.swift
//  BravePlay
//
//  Created by yaosixu on 16/8/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit
import WebKit

class MoreDetailWebViewController: UIViewController {

    var hidenWebView :Bool = true {
        didSet {
            if hidenWebView == true {
                webView.hidden = true
            } else {
                webView.hidden = false
            }
        }
    }
    
    private let webView = UIWebView()
    private let customScrollView: UIScrollView = UIScrollView()
    private var scheduleContents: [ActivitysScheduleContents] = []
    private var singleContents: [ActivitysSingleContents] = []
    var cellHeight :Float? = nil
    
    private var url:NSURL? {
        didSet {
            if let newUrl = url {
                webView.loadRequest(NSURLRequest(URL: newUrl))
            }
        }
    }
    
    init(scheduleContents: [ActivitysScheduleContents],singleContents: [ActivitysSingleContents]) {
        self.scheduleContents = scheduleContents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor ( red: 0.1647, green: 0.2, blue: 0.2196, alpha: 1.0 )
        addScrollView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false
        navigationController?.navigationBar.alpha = 1.0
        let titleLabel = UILabel()
        titleLabel.frame.origin = CGPoint(x: 0.0, y: 0.0)
        titleLabel.text = "更多图文详情"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addScrollView() {
        customScrollView.frame = CGRect(x: 0, y: 74, width: view.bounds.size.width, height: 10000)
//        customScrollView.backgroundColor = UIColor ( red: 0.1647, green: 0.2, blue: 0.2196, alpha: 1.0 )
        customScrollView.backgroundColor = UIColor.whiteColor()
        view.addSubview(customScrollView)
        addWebView()
    }
    
    private func addWebView() {
        webView.frame = CGRect(x: 10, y: 0, width: view.bounds.size.width - 20, height: view.bounds.size.height)
        webView.backgroundColor = UIColor ( red: 0.1176, green: 0.1373, blue: 0.1569, alpha: 1.0 )
        webView.opaque = false
        webView.scrollView.bounces = false
        webView.userInteractionEnabled = false
        customScrollView.addSubview(webView)
        loadHtmlString(scheduleContents[0].content)
    }
    
    func loadHtmlString(html:String) {
        let newHtml = html.stringByReplacingOccurrencesOfString("data-src", withString: "src", options: NSStringCompareOptions.LiteralSearch, range: nil)
        var content: String = "<html>"
        
//        content += "<script type=\"text/javascript\">"
//        content += "window.onload = function() {"
//        content += "window.location.href = \"ready://\" + document.body.offsetHeight;}"
//        content +=  "</script>"
        
        content += "<head>"
        content += "<style type=\"text/css\">"
        content += "img {max-width: 100%}"
        content += "</style>"
        content += "</head>"

        content += "<body style=\"background-color: transparent\">"
        content += "<p>"
        content += "<font color=\"white\">"
        content += newHtml
        content += "</font>"
        content += "</p>"
        content += "</body>"
        content += "</html>"

        webView.loadHTMLString(content, baseURL: nil)
    }
}
