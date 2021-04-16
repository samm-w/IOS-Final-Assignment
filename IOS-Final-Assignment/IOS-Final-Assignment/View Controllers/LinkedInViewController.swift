//
//  LinkedInViewController.swift
//  Principal Author: Sam Whelan
//  Created by  on 4/9/21.
//  Description: Displays a webview of each devs Github page when their name is clicked on
//  in the about us page

import UIKit
import WebKit

class LinkedInViewController: UIViewController, WKNavigationDelegate {
    
    //The webview that will display the Github page
    @IBOutlet var webView: WKWebView!
    //The activity view that will show while the webpage is not done loading
    @IBOutlet var activity: UIActivityIndicatorView!
    
    //Will show the activity view while the web page is not done loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activity.startAnimating()
        activity.isHidden = false
    }
    
    //Will hide the activity view once the loading is done
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activity.stopAnimating()
        activity.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Here to give access to main delegate
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Allows for the web view to pull the url from the app delegate array of devs
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
