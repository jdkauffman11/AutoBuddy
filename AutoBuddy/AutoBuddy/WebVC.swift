//
//  WebVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/20/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class WebVC: UIViewController {
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var navigationBar: UINavigationBar!
    var car = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.backgroundColor = UIColor.white
        navItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        if car.contains(" ")
        {
            car = car.replacingOccurrences(of: " ", with: "%20")
        }
        if let url = URL(string: "https://www.google.com/search?q=\(car)%20for%20sale")
        {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    func backAction()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
