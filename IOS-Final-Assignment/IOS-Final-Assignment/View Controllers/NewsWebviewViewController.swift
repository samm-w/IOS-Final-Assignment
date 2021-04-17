//
//  NewsWebviewViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 4/17/21.
//

import UIKit
import WebKit

class NewsWebviewViewController: UIViewController {
    
    @IBOutlet var webView : WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: url!)!))
    }

}
