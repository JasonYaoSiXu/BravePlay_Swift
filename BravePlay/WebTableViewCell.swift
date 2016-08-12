//
//  FastWebTableViewCell.swift
//  livehouse-swift
//
//  Created by liucien on 15/12/10.
//  Copyright © 2015年 Beijing MingFengYueMeng Culture Technology Development Co. Ltd. All rights reserved.
//

import UIKit
import WebKit

class FastWebTableViewCell: UITableViewCell {
    
    typealias NeedUpdateBlock = (Void) -> (Void)
    
    var needUpdateBlock:NeedUpdateBlock? = nil
    //    private var webView = WKWebView()
    private var webView = UIWebView()
    var cellHeight :Float? = nil
    
    var hidenWebView :Bool = true {
        didSet {
            if hidenWebView == true {
                webView.hidden = true
            } else {
                webView.hidden = false
            }
        }
    }
    
    private var url:NSURL? {
        didSet {
            if let newUrl = url {
                webView.loadRequest(NSURLRequest(URL: newUrl))
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialize()
    }
    
    private func initialize() {
        webView.delegate = self
        webView.scrollView.bounces = false
        webView.userInteractionEnabled = false
        webView.backgroundColor = UIColor ( red: 0.1176, green: 0.1373, blue: 0.1569, alpha: 1.0 )
        webView.opaque = false
        contentView.addSubview(webView)
        webView.frame = CGRectInset(self.contentView.bounds, 20, 8)
        contentView.backgroundColor = UIColor.whiteColor()
        webView.hidden = true
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "webView.scrollView.contentSize" {
            if let nsSize = change?[NSKeyValueChangeNewKey] as? NSValue {
                let height = nsSize.CGSizeValue().height
                // Do something here using content height.
                let newHeight = height + 2 * 8
                self.cellHeight = Float(newHeight)
                self.webView.hidden = false
                if let block = self.needUpdateBlock {
                    block()
                }
                
            }
        }
    }
    
    override func layoutSubviews() {
        webView.frame = CGRectInset(self.contentView.bounds, 20, 8)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        webView.stopLoading()
        webView.hidden = true
        self.cellHeight = nil
    }
    
    func loadHtmlString(html:String) {
        var content: String = "<html>"
        
        
        content += "<script type=\"text/javascript\">"
        content += "window.onload = function() {"
        content += "window.location.href = \"ready://\" + document.body.offsetHeight;}"
        content +=  "</script>"
        
        content += "<head>"
        content += "<style type=\"text/css\">"
        content += "img {max-width: 100%}"
        content += "</style>"
        content += "</head>"
        
        content += "<body style=\"background-color: transparent\">"
        content += "<p>"
        content += "<font color=\"white\">"
        content += html
        content += "</font>"
        content += "</p>"
        content += "</body>"
        content += "</html>"
        
        self.webView.loadHTMLString(content, baseURL: nil)
    }
    
    func calcWebViewCellHeight(webView:UIWebView) {
        //防止重复计算
        //        if let _ = self.cellHeight {
        //            return
        //        }
        
        guard let height  =  webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight;")?.floatValue else {
            return
        }
        
        let newHeight = height + 2 * 8
        self.cellHeight = Float(newHeight)
        
        webView.hidden = false
        if let block = self.needUpdateBlock {
            block()
        }
    }
    
    func requireRowHeight(tableView:UITableView) -> CGFloat {
        guard let height = self.cellHeight else {
            return CGFloat(20.0)
        }
        return CGFloat(height)
    }
    
    func calcHeightFinished(height:CGFloat) {
        let newHeight = height + 2 * 8
        self.cellHeight = Float(newHeight)
        self.webView.hidden = false
        if let block = self.needUpdateBlock {
            block()
        }
    }
    
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
extension FastWebTableViewCell:UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL  where url.scheme == "ready" {
            let height = (url.host?.floatValue ?? 0.0) + 20
            self.calcHeightFinished(CGFloat(height))
        }
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
    }
}

