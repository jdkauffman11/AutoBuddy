//
//  SavedSearchVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 4/15/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit
import Firebase
class SavedSearchVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var email = ""
    
    @IBOutlet var tableView: UITableView!
    var searchHistory = [String]()
    var dates = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let searches = value?["searches"] as! NSDictionary
            
            for i in 0 ..< searches.allValues.count
            {
                self.searchHistory.append(searches.allValues[i] as! String)
                self.dates.append(searches.allKeys[i] as! String)
            }
            //self.searchHistory = searches.allValues as! [String]
            //print("Searches: \(searches ?? [""])")
            self.tableView.reloadData()
        })
        { (error) in
            print(error.localizedDescription)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchHistory.count
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        performSegue(withIdentifier: "loadSavedData", sender: self)
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = searchHistory[indexPath.row]
        //cell.detailTextLabel?.text = dates[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = self.tableView.backgroundColor
        // Configure the cell...
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "loadSavedSearch"
        {
            let next = segue.destination as! DetailsVC
            //let next = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchHistory.removeAll()
        dates.removeAll()
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
