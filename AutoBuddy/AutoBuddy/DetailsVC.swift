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
    var trimOne = ""
    var trimTwo = ""
    var key = ""
    
    var carToPass: String!
    
    @IBOutlet var vehicleOneTitleButton: UIButton!
    @IBOutlet var vehicleTwoTitleButton: UIButton!
    
    @IBOutlet var findDealerships: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        vehicleOneTitleButton.setTitle(nameOne, for: .normal)
        vehicleTwoTitleButton.setTitle(nameTwo, for: .normal)
        
        print(idOne)
        print(idTwo) 
        
        getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/equipment/\(idOne)?fmt=json&api_key=\(key)")
    }

    override func viewDidLoad() {
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
                        if resultJSON["styles"] as? NSArray == nil
                        {
                            print("Incorrect Data Submitted")
                        }
                        else
                        {
                            
                            print(resultJSON)
//                            let styles = resultJSON["styles"] as! NSArray
//                            self.trimDetails = styles
//                            for i in 0..<styles.count
//                            {
//                                let name = styles[i] as! Dictionary<String, Any>
//                                self.trims.append(name["name"] as! String)
//                                self.ids.append(name["id"] as! CLong)
//                            }
//                            
//                            DispatchQueue.main.async() { // Async task to handle UI updating
//                                self.tableView.reloadData()
//                                self.tableView.isHidden = false
//                                return
//                            }
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
