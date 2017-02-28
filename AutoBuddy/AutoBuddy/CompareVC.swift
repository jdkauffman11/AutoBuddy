//
//  CompareVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 2/27/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class CompareVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let years : Array<Any> = getYearRange()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getJSONData(path: String)
//    {
//        // prepare json data
//        let json: [String: Any] = ["title": "ABC", "dict": ["1":"First", "2":"Second"]]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        
//        // create post request
//        let url = URL(string: path + "mbaawxhjajwzsqs7pgxnbefj")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        // insert json data to the request
//        request.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
//                return
//            }
//            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
//            }
//        }
//        
//        task.resume()
//
//    }
    
    func getYearRange() -> Array<Any>
    {
        var yearArray:Array<Any> = []
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year!
        
        
        for i in (1980..<year).reversed()
        {
            yearArray.append(i)
        }
        
        return yearArray
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
