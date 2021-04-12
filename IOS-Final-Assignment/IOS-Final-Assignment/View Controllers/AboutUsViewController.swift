//
//  AboutUsViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func unwindToAboutUsViewController(sender: UIStoryboardSegue){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.people.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.people[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.people[rowNum].program
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
        
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
