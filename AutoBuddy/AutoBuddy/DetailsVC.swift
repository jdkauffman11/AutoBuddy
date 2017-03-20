//
//  DetailsVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/18/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    
    var nameOne: String!
    var nameTwo: String!
    var idOne: CLong!
    var idTwo: CLong!
    var key: String!
    
    @IBOutlet var vehicleOneTitleButton: UIButton!
    @IBOutlet var vehicleTwoTitleButton: UIButton!
    @IBOutlet var findDealerships: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        vehicleOneTitleButton.titleLabel?.text = nameOne
        vehicleTwoTitleButton.titleLabel?.text = nameTwo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOver(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
