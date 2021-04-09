//
//  LinkedInViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 4/9/21.
//

import UIKit
import WebKit

class LinkedInViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.startAnimating()
        activity.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let urlAddress = URL(string: mainDelegate.selectedURL)
        let url = URLRequest(url: urlAddress!)
        webView.load(url)
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
