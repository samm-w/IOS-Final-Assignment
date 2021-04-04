//
//  AboutUsViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit

class AboutUsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listData: Array<String> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        let rowNum = indexPath.row
        tableCell.textLabel?.text = listData[rowNum]
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 50)
        
        return tableCell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listData = ["Sam Whelan", "Anthony Doss", "Edmund Leung"]

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
