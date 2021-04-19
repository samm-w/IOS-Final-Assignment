//
//  Tab2ViewController.swift
//  IOS-Final-Assignment
//  Prinicpal Author: Edmund Leung
//  Description: Navigates the user to the Gov. of Canada Covid awareness resouces
//  Created by  on 4/18/21.
//

import UIKit
import WebKit

class Tab2ViewController: UIViewController, WKNavigationDelegate{

    //Links to the webview on the page
    @IBOutlet var webView: WKWebView!
    //Links to the indicator view so that the webview can show loading
    @IBOutlet var activity: UIActivityIndicatorView!
    
    //This method will allow the activity indicator to be animated and visible
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    //This method will hide the animation once the page is loaded
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.isHidden = true
        activity.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Creates the webview link once the string is entered below
        let urlAddress = URL(string: "https://www.canada.ca/en/public-health/services/diseases/2019-novel-coronavirus-infection/awareness-resources.html")
        
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self

        // Do any additional setup after loading the view.
    }

}
