//
//  WebVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 3/20/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class WebVC: UIViewController {
    @IBOutlet var webView: UIWebView!
    var car = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //webView.loadRequest(URLRequest(url: URL(fileURLWithPath: "https://www.google.com/search?q=" + car + "for sale")))
        
        webView.loadRequest(URLRequest(url: URL(string: "https://www.google.com/search?q=" + car + "for sale")!))
        // Do any additional setup after loading the view.
        
//        let url = URL(string: "https://www.google.com/search?q=" + car + "for sale");
//        let req = URLRequest(url: url! as URL);
//        webView.loadRequest(req as URLRequest);
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
