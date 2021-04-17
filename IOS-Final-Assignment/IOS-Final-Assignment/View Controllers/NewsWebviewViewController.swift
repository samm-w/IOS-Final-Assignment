//
//  NewsWebviewViewController.swift
//  IOS-Final-Assignment
//  Prinicpal Author: Edmund Leung
//  Description: A class to load the website that is linked to the specific article
//  Created by  on 4/17/21.

import UIKit
import WebKit

class NewsWebviewViewController: UIViewController {
    
    @IBOutlet var webView : WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the URL webpage of the article that is selected
        webView.load(URLRequest(url: URL(string: url!)!))
    }

}
