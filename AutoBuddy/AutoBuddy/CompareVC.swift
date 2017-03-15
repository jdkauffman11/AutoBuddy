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
    
    var trims = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        year.delegate = self
        make.delegate = self
        model.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trims.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.trims[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadTrims(_ sender: Any) {
        dismissKeyboard()
        if make.text != "" && model.text != "" && year.text != ""
        {
            getJSONData(path: "https://api.edmunds.com/api/vehicle/v2/" + make.text! + "/" + model.text! + "/" + year.text! + "?fmt=json&api_key=")
        }
    }
    
    func getJSONData(path: String)
    {
        // prepare json data
        let json = "{\"id\":\"ABC\", \"year\": \"2000\", \"styles\":[{\"id\":\"ABC\", \"name\":\"ABC\", \"submodel\":{\"body\":\"ABC\", \"modelName\":\"ABC\",\"niceName\":\"ABC\"} \"trim\":\"ABC\"}]}"
        //var data = json.data(using: .utf8)!
        //let json: [String: Any] = ["id": "ABC", "dict": ["1":"First", "2":"Second"]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: path + "mbaawxhjajwzsqs7pgxnbefj")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
                self.parseJSON(json: responseJSON)
                self.tableView.isHidden = false
            }
        }
        
        task.resume()
        
//        let config = URLSessionConfiguration.default // Session Configuration
//        let session = URLSession(configuration: config) // Load configuration into Session
//        let url = URL(string: path + "mbaawxhjajwzsqs7pgxnbefj")!
//        
//        let task = session.dataTask(with: url, completionHandler:
//            {
//            (data, response, error) in
//            
//            if error != nil
//            {
//                
//                print(error!.localizedDescription)
//                
//            }
//            else
//            {
//                do {
//                    if let resultJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
//                    {
//                        //Implement your logic
//                        print(resultJSON)
//                        
//                        DispatchQueue.main.async(){
//                            self.parseJSON(json: resultJSON)
//                            self.tableView.isHidden = false
//                        }
//                    }
//                }
//                catch
//                {
//                    
//                    print("error in JSONSerialization")
//                    
//                }
//                
//                
//            }
//            
//        })
//        task.resume()
    }
    
    func parseJSON(json: [String: Any])
    {
//        if let styles = json["styles"] as? [[String: Any]]
//        {
//            for style in styles
//            {
//                if let names = style["name"]
//                {
//                    for name in names
//                    {
//                        trims.append(name)
//                    }
//                    
//                }
//            }
//        }
        tableView.reloadData()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
