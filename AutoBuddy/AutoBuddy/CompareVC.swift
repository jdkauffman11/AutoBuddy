//
//  CompareVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 2/27/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class CompareVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var year: UITextField!
    @IBOutlet var make: UITextField!
    @IBOutlet var model: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    
    private var trims = [String]() // trims that the vehicle comes in
    private var status = 1 // used to keep track of current status
    private var trimDetails: NSArray = [] // holds the values of all trims. when one is selected, the relevant info is passed
    private var selectedTrimIndex = 0 // index of the trim selected
    private var vehicleOne: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Step \(status): Enter vehicle information"
        subtitleLabel.text = "Vehicle \(status):"
        nextButton.isHidden = true
        
        year.delegate = self
        make.delegate = self
        model.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.white
        tableView.backgroundColor = UIColor.clear
        tableView.isHidden = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loadTrims(_ sender: Any) {
        dismissKeyboard()
        if make.text != "" && model.text != "" && year.text != ""
        {
            getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/" + make.text! + "/" + model.text! + "/" + year.text! + "?fmt=json&api_key=")
            self.nextButton.isHidden = false
        }
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        status += 1
        if status == 2
        {
            titleLabel.text = "Step \(status): Enter vehicle information"
            subtitleLabel.text = "Vehicle \(status):"
//CHECK THIS CONDITION
            // Save data and pull any additional data, clear fields
            if trimDetails.count != 0
            {
                // save data
                let toBeSent = trimDetails[selectedTrimIndex]
                vehicleOne = "\(self.year.text) \(self.make) \(self.model)"
                
                // clear the fields
                self.year.text = ""
                self.make.text = ""
                self.model.text = ""
                self.trimDetails = [] // would be reset anyway
                
                // Hide buttons
                nextButton.isHidden = true
                
                
            }
        }
        else
        {
            // Segue (Send two strings of vehicle data as well as year make and model)
            // Add code to send data to VC
            performSegue(withIdentifier: "compare", sender: nil)
        }
    }
    
    func getJSONData(path: String)
    {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: path + "mbaawxhjajwzsqs7pgxnbefj")!
        
        let task = session.dataTask(with: url, completionHandler:
            {
                (data, response, error) in
                if error != nil
                {
                    print(error!.localizedDescription)
                }
                else
                {
                    do {
                        let resultJSON = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                        // Parse the data in the result
                        let styles = resultJSON["styles"] as! NSArray
                        self.trimDetails = styles
                        for i in 0..<styles.count
                        {
                            let name = styles[i] as! Dictionary<String, Any>
                            self.trims.append(name["name"] as! String)
                        }
                        DispatchQueue.main.async() { // Async task to handle UI updating
                            self.tableView.reloadData()
                            self.tableView.isHidden = false
                            return
                        }
                    }
                    catch
                    {
                        print("Error: \(error)")
                    }
                }
        })
        task.resume()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trims.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.trims[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTrimIndex = indexPath.row
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
