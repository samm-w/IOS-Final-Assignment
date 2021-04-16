//
//  WhoInfoViewController.swift
//  Principal Author: Sam Whelan
//  Created by  on 3/22/21.
//  Description: This class creates the web view for the WHO page that will provide
//  information from the WHO website, and let users search for more COVID information

import UIKit
import WebKit

class WhoInfoViewController: UIViewController, WKNavigationDelegate{
    
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
        let urlAddress = URL(string: "https://who.int/emergencies/diseases/novel-coronavirus-2019")
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
