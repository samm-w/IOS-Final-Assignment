//
//  AboutUsViewController.swift
//  Principal Author: Sam Whelan
//  Created by  on 3/22/21.
//  Description: Creates the about us view by pulling the devs information from the sql db
//  and app delegate to display

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Calls the main delegate so that it can be accessed in this view controller
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Allows the GitHub web view link to be unwinded to this page
    @IBAction func unwindToAboutUsViewController(sender: UIStoryboardSegue){
        
    }
    
    //Returns how many rows will be in the table based on how many people are in the db
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.people.count
    }
    
    //Returns the height that has been set for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Indicates what each cell should display, in this case the information of each dev
    //stored in the db
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        //Created to set the row information to fit in the site cell labels
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.people[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.people[rowNum].program
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
        
    }
    
    //When the row is selected it transfers to the webview which will display each dev's
    //github page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainDelegate.selectedURL = mainDelegate.people[indexPath.row].url!
        performSegue(withIdentifier: "ChooseSegueToView", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainDelegate.readDataFromDatabase()
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
