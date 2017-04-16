//
//  DetailsVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/18/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit
import Firebase
class DetailsVC: UIViewController {
    
    var email = ""
    var nameOne = ""
    var nameTwo = ""
    var idOne = 0
    var idTwo = 0
    var key = ""
    var firstTrim = ""
    var secondTrim = ""
    
    @IBOutlet var trimOne: UILabel!
    @IBOutlet var doorsOne: UILabel!
    @IBOutlet var mpgOne: UILabel!
    @IBOutlet var engineOne: UILabel!
    @IBOutlet var weightOne: UILabel!
    @IBOutlet var horsepowerOne: UILabel!
    @IBOutlet var torqueOne: UILabel!
    
    @IBOutlet var trimTwo: UILabel!
    @IBOutlet var doorsTwo: UILabel!
    @IBOutlet var mpgTwo: UILabel!
    @IBOutlet var weightTwo: UILabel!
    @IBOutlet var engineTwo: UILabel!
    @IBOutlet var horsepowerTwo: UILabel!
    @IBOutlet var torqueTwo: UILabel!
    
    
    var carToPass: String!
    
    @IBOutlet var vehicleOneTitleButton: UIButton!
    @IBOutlet var vehicleTwoTitleButton: UIButton!
    
    @IBOutlet var findDealerships: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        vehicleOneTitleButton.setTitle(nameOne, for: .normal)
        vehicleTwoTitleButton.setTitle(nameTwo, for: .normal)
        self.trimOne.text = "Trim: \(firstTrim)"
        self.trimTwo.text = "Trim: \(secondTrim)"
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
//        DispatchQueue.main.async {
//            self.getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/styles/\(self.idOne!)/equipment?fmt=json&api_key=\(self.key)", vehicle: 1)
//         
//        }
//        
//        DispatchQueue.main.async {
//            
//            self.getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/styles/\(self.idTwo!)/equipment?fmt=json&api_key=\(self.key)", vehicle: 2)
//        }
        
        
    }
    
    func getJSONData(path: String, vehicle: Int)
    {
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: path)!
        let task = session.dataTask(with: url, completionHandler:
            {(data, response, error) in
                if error != nil
                {
                    print("Session Error: \(error?.localizedDescription ?? "")")
                }
                else
                {
                    do
                    {
                        let resultJSON = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                        // Parse the data in the result
                        if resultJSON["equipment"] as? NSArray == nil
                        {
                            print("Incorrect Data Submitted")
                        }
                        else
                        {
                            let equipment = resultJSON["equipment"] as! NSArray
                            
                            for i in 0 ..< equipment.count
                            {
                                let type = equipment[i] as! Dictionary<String, Any>
                                if let name = type["name"] as? String
                                {
                                    if name == "Engine"
                                    {
                                        if let equipmentType = type["equipmentType"]
                                        {
                                            if (equipmentType as AnyObject).contains("ENGINE")
                                            {
                                                let cylinder = type["cylinder"]
                                                let size = type["size"]
                                                let valves = type["totalValves"]
                                                let horsepower = type["horsepower"]
                                                let torque = type["torque"]
                                                let configuration = type["configuration"]
                                                if vehicle == 1
                                                {
                                                    DispatchQueue.main.async() {
                                                        if horsepower != nil
                                                        {
                                                            self.horsepowerOne.text = "Horsepower: \(horsepower!)"
                                                        }
                                                        
                                                        if torque != nil
                                                        {
                                                            self.torqueOne.text = "Torque: \(torque!)"
                                                        }
                                                        
                                                        if valves != nil && size != nil && configuration != nil && cylinder != nil
                                                        {
                                                            self.engineOne.text = "Engine: \(valves!) Valve \(size!)L. \(configuration!)\(cylinder!)"
                                                            //self.engineOne.text = "Engine: \(Int(valves as! Int)) Valve \(Int(size as! Int))L. \(configuration!)\(Int(cylinder as! Int))"
                                                        }
                                                        
                                                        
                                                    }
                                                }
                                                else
                                                {
                                                    DispatchQueue.main.async() {
                                                        if horsepower != nil
                                                        {
                                                            self.horsepowerTwo.text = "Horsepower: \(horsepower!)"
                                                        }
                                                        
                                                        if torque != nil
                                                        {
                                                            self.torqueTwo.text = "Torque: \(torque!)"
                                                        }
                                                        
                                                        if valves != nil && size != nil && configuration != nil && cylinder != nil
                                                        {
                                                            self.engineTwo.text = "Engine: \(valves!) Valve \(size!)L. \(configuration!)\(cylinder!)"
                                                            //self.engineOne.text = "Engine: \(Int(valves as! Int)) Valve \(Int(size as! Int))L. \(configuration!)\(Int(cylinder as! Int))"
                                                        }
                                                        
                                                        
                                                    }

                                                }
                                                
                                            }
                                        }
                                    }
                                    else if name == "Doors"
                                    {
                                        let attributes = type["attributes"] as! NSArray
                                        let doors = attributes[0] as! Dictionary <String, Any>
                                        if let value = doors["value"]
                                        {
                                            if vehicle == 1
                                            {
                                                DispatchQueue.main.async() {
                                                    self.doorsOne.text = "Doors: \(value)"
                                                    
                                                }
                                            }
                                            else
                                            {
                                                DispatchQueue.main.async() {
                                                    self.doorsTwo.text = "Doors: \(value)"
                                                    
                                                }
                                            }
                                        }
                                    }
                                    else if name == "Specifications"
                                    {
                                        var city: Any?
                                        var highway: Any?
                                        var weight: Any?
                                        let attributes = type["attributes"] as! NSArray
                                        for i in 0 ..< attributes.count
                                        {
                                            let mpg = attributes[i] as! Dictionary <String, Any>
                                            
                                            if mpg["name"] as! String == "Epa City Mpg"
                                            {
                                                city = mpg["value"]
                                            }
                                            else if mpg["name"] as! String == "Epa Highway Mpg"
                                            {
                                                highway = mpg["value"]
                                            }
                                            else if mpg["name"] as! String == "Curb Weight"
                                            {
                                                weight = mpg["value"]
                                            }
                                        }
                                        if vehicle == 1
                                        {
                                            DispatchQueue.main.async() {
                                                self.mpgOne.text = "MPG: City/Highway \(city!) / \(highway!)"
                                                self.weightOne.text = "Weight: \(weight!) lbs."
                                            }
                                        }
                                        else
                                        {
                                            DispatchQueue.main.async() {
                                                self.mpgTwo.text = "MPG: City/Highway \(city!) / \(highway!)"
                                                self.weightTwo.text = "Weight: \(weight!) lbs."
                                            }
                                        }
                                    }
                                }
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
    
    @IBAction func SearchDealerships(_ sender: Any)
    {
        self.performSegue(withIdentifier: "searchDealerships", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchVehicleOne(_ sender: Any) {
        carToPass = nameOne
        self.performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    @IBAction func searchVehicleTwo(_ sender: Any) {
        carToPass = nameTwo
        self.performSegue(withIdentifier: "webSegue", sender: self)
    }
    
    @IBAction func saveSearch(_ sender: Any) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) % 12
        let minutes = calendar.component(.minute, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        //ref.child("users/\(userID!)/").setValue(["searches": "#"])
        
        let searchName = nameOne + " / " + nameTwo
        ref.child("users/\(userID!)/searches").child("\(month)-\(day)-\(year), \(hour):\(minutes)").setValue(searchName)
    
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "webSegue"
        {
            let next = segue.destination as! WebVC
            next.car = self.carToPass
        }
    }
    
    
}
