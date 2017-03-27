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
    var vehicle: Int!
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
        
        vehicle = 1
        //getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/equipment/\(idOne!)?fmt=json&api_key=\(key)")
        getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/styles/\(idOne!)/equipment?fmt=json&api_key=\(key)")
        vehicle = 2
        //getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/styles/\(idTwo!)/equipment?fmt=json&api_key=\(key)")
        
    }
    
    override func viewDidLoad() {
        
        self.trimOne.text = "Trim: \(firstTrim)"
        self.trimTwo.text = "Trim: \(secondTrim)"
        print(idOne)
        print(idTwo)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
                            print("else")
                            let equipment = resultJSON["equipment"] as! NSArray
                            
                            for i in 0 ..< equipment.count
                            {
                                print("for")
                                let type = equipment[i] as! Dictionary<String, Any>
                                if let name = type["name"] as? String
                                {
                                    if name == "Engine"
                                    {
                                        print(type)
                                        let cylinder = type["cylinder"] as? Int
                                        print(1)
                                        let size = type["size"] as? Int
                                        print(2)
                                        let valves = type["totalValves"] as? Int
                                        print(3)
                                        let horsepower = type["horsepower"] as? Int
                                        print(4)
                                        let torque = type["torque"] as? Int
                                        print(5)
                                        let configuration = type["configuration"] as? String
                                        if self.vehicle == 1
                                        {
                                            print("second if")
                                            self.horsepowerOne.text = "\(horsepower)"
                                            self.torqueOne.text = "\(torque)"
                                            self.engineOne.text = "\(valves) Valve \(size)L. \(configuration)\(cylinder)"
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
