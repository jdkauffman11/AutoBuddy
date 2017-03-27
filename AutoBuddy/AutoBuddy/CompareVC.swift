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
    private var ids = [CLong]() // ids for each trim
    private var status = 1 // used to keep track of current status
    private var trimDetails: NSArray = [] // holds the values of all trims. when one is selected, the relevant info is passed
    private var selectedTrimIndex = 0 // index of the trim selected
    private var vehicleOne = ""
    
    private var nameOne = ""
    private var nameTwo = ""
    private var idOne = 0
    private var idTwo = 0
    private var trimOne = ""
    private var trimTwo = ""
    private var key = "mbaawxhjajwzsqs7pgxnbefj"
    
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
        trims = []
        if make.text != "" && model.text != "" && year.text != ""
        {
            getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/" + make.text! + "/" + model.text! + "/" + year.text! + "?fmt=json&api_key=\(key)")
        }
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        parseData(data: trimDetails[selectedTrimIndex] as! Dictionary<String, Any>)
        
        status += 1
        
        if status == 2 && make.text != "" && model.text != "" && year.text != ""
        {
            titleLabel.text = "Step \(status): Enter vehicle information"
            subtitleLabel.text = "Vehicle \(status):"
            //CHECK THIS CONDITION
            // Save data and pull any additional data, clear fields
            if trimDetails.count != 0
            {
                vehicleOne = "\(self.year.text) \(self.make) \(self.model)"
                
                // clear the fields
                self.year.text = ""
                self.make.text = ""
                self.model.text = ""
                self.trimDetails = [] // would be reset anyway
                self.trims = []
                self.ids = []
                self.tableView.reloadData()
                self.tableView.isHidden = true
                
                // Hide buttons
                nextButton.isHidden = true
                
                
            }
        }
        else if status > 2
        {
            self.performSegue(withIdentifier: "compare", sender: self)
        }
    }
    
    func parseData(data: Dictionary<String, Any>)
    {
        if status == 1
        {
            idOne = ids[selectedTrimIndex]
            nameOne = year.text! + " " + make.text! + " " + model.text!
            trimOne = trims[selectedTrimIndex]
        }
        else if status == 2
        {
            idTwo = ids[selectedTrimIndex]
            nameTwo = year.text! + " " + make.text! + " " + model.text!
            trimTwo = trims[selectedTrimIndex]
        }
        
        
    }
    
    func getJSONData(path: String)
    {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: path)!
        let task = session.dataTask(with: url, completionHandler:
            {(data, response, error) in
                if error != nil
                {
                    print("Session Error: \(error?.localizedDescription)")
                }
                else
                {
                    do
                    {
                        let resultJSON = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                        // Parse the data in the result
                        if resultJSON["styles"] as? NSArray == nil
                        {
                            print("Incorrect Data Submitted")
                            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            let styles = resultJSON["styles"] as! NSArray
                            self.trimDetails = styles
                            for i in 0..<styles.count
                            {
                                let name = styles[i] as! Dictionary<String, Any>
                                self.trims.append(name["name"] as! String)
                                self.ids.append(name["id"] as! CLong)
                            }
                            
                            DispatchQueue.main.async() { // Async task to handle UI updating
                                self.tableView.reloadData()
                                self.tableView.isHidden = false
                                self.nextButton.isHidden = false
                                return
                            }
                        }
                    }
                    catch
                    {
                        print("Serialization Error: \(error)")
                    }
                }
        })
        task.resume()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if self.tableView.indexPathForSelectedRow != nil
        {
            if segue.identifier == "compare"
            {
                let next = segue.destination as! DetailsVC
                //let next = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
                next.key = self.key
                next.idOne = self.idOne
                next.idTwo = self.idTwo
                next.nameOne = self.nameOne
                next.nameTwo = self.nameTwo
                next.firstTrim = self.trimOne
                next.secondTrim = self.trimTwo
            }
        }
    }
    
    
    
    
}
