//
//  AboutUsViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var devListData = ["Sam Whelan", "Edmund Leung", "Anthony Doss"]
    var siteData = [ "https://github.com/samm-w", "https://github.com/leunged", "https://github.com/AnthonyDoss" ]
    
    @IBAction func unwindToAboutUsViewController(sender: UIStoryboardSegue){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devListData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = devListData[rowNum]
        tableCell.secondaryLabel.text = siteData[rowNum]
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainDelegate = UIApplication.shared as! AppDelegate
        mainDelegate.selectedURL = siteData[indexPath.row]
        performSegue(withIdentifier: "ChooseSegueToView", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
