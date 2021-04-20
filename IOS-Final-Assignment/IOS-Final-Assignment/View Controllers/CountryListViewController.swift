//
//  CountryListViewController.swift
//  IOS-Final-Assignment
//
//  Created by  on 3/22/21.
//

import UIKit


var cases = 0.0
var deaths = 0.0
var active = 0.0
var recovered = 0.0
var flag = ""

class getData: ObservableObject {
    
    @Published var data : Country!
    
    init(country:String){
        
    }
    
    
    func updateData(country:String){
        print(country)
        
        let url = "https://corona.lmao.ninja/v3/covid-19/countries/\(country)"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){(data,response,error) in
            if error != nil{
                print(error?.localizedDescription ?? "Error")
                return
            }
            do {
                let json = try JSONDecoder().decode(Country.self, from: data!)
                DispatchQueue.main.async {
                    self.data = json
                  
                    cases = self.data.cases
                    deaths = self.data.deaths
                    active = self.data.active
                    recovered = self.data.recovered
                    flag = self.data.countryInfo.flag
                    
                    
                }
            }catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}


class CountryListViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var lblCases : UILabel!
    @IBOutlet var lblDeaths : UILabel!
    @IBOutlet var lblRecovered : UILabel!
    @IBOutlet var lblActive : UILabel!
    @IBOutlet var lblFlag : UIImageView!
    @IBOutlet var tfInput : UITextField!
    
    //Returns the text field after the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submit(sender : Any){
    
        let c = tfInput.text!
        
        let data = getData(country: c)
        data.updateData(country: c)
        
        
    }
    func update(){
        let c = tfInput.text!
        
        let data = getData(country: c)
        data.updateData(country: c)
    }
    @IBAction func printLabel(sender : Any){
        
       
        lblCases.text = "Cases :"+String(cases)
        lblDeaths.text = "Deaths :"+String(deaths)
        lblActive.text = "Active :"+String(active)
        lblRecovered.text = "Recovered :"+String(recovered)
        let imageUrl = URL(string: flag)!
        let data = try? Data(contentsOf: imageUrl)
        lblFlag.image = UIImage(data: data!)
        
        
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
