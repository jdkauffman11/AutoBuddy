//
//  DetailsVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/18/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    
    var nameOne = ""
    var nameTwo = ""
    var idOne: CLong!
    var idTwo: CLong!
    var key = ""
    var vehicle = 1
    var firstTrim = ""
    var secondTrim = ""
    
    @IBOutlet var trimOne: UILabel!
    @IBOutlet var doorsOne: UILabel!
    @IBOutlet var mpgOne: UILabel!
    @IBOutlet var engineOne: UILabel!
    @IBOutlet var horsepowerOne: UILabel!
    @IBOutlet var torqueOne: UILabel!
    
    @IBOutlet var trimTwo: UILabel!
    
    
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
        
        populateFields()
    }
    
    func populateFields()
    {
        getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/styles/\(idOne!)/equipment?fmt=json&api_key=\(key)")
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
                                                print("Equipment Type: \(equipmentType)")
                                                print(type)
                                                
                                                let cylinder = type["cylinder"]
                                                let size = type["size"]
                                                let valves = type["totalValves"]
                                                let horsepower = type["horsepower"]
                                                let torque = type["torque"]
                                                let configuration = type["configuration"]
                                                if self.vehicle == 1
                                                {
                                                    DispatchQueue.main.async() {
                                                        if horsepower != nil
                                                        {
                                                            print("Should set Horsepower")
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
                                                
                                            }
                                        }
                                        print("done with engine")
                                    }
                                    else if name == "Doors"
                                    {
                                        print("Looking for doors")
                                        let attributes = type["attributes"] as! NSArray
                                        print("Check value conditional")
                                        let doors = attributes[0] as! Dictionary <String, Any>
                                        print(doors)
                                        if let value = doors["value"]
                                        {
                                            print("Value check passed")
                                            if self.vehicle == 1
                                            {
                                                DispatchQueue.main.async() {
                                                    print("Doors label set")
                                                    self.doorsOne.text = "Doors: \(value)"
                                                    
                                                }
                                            }
                                        }
                                        print("Done with doors")
                                    }
                                    else if name == "Specifications"
                                    {
                                        print("Looking for mpg")
                                        var city: Any?
                                        var highway: Any?
                                        let attributes = type["attributes"] as! NSArray
                                        print(attributes)
                                        for i in 0 ..< attributes.count
                                        {
                                            print("Attributes loaded correctly")
                                            let mpg = attributes[i] as! Dictionary <String, Any>
                                            
                                            if mpg["name"] as! String == "Epa City Mpg"
                                            {
                                                print("found city")
                                                city = mpg["value"]
                                            }
                                            else if mpg["name"] as! String == "Epa Highway Mpg"
                                            {
                                                print("found highway")
                                                highway = mpg["value"]
                                            }
                                        }
                                        if self.vehicle == 1
                                        {
                                            DispatchQueue.main.async() {
                                                print("mpg label set")
                                                self.mpgOne.text = "MPG: City/Highway \(city!) / \(highway!)"
                                                
                                            }
                                        }
                                        print("Done with mpg")
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
        
        print("done")
        
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
