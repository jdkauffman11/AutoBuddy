//
//  LoginVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 1/18/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet var emailBox: UITextField!
    @IBOutlet var passwordBox: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailBox.delegate = self
        passwordBox.delegate = self
    
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginTextBox(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    @IBAction func SignUpTextBox(_ sender: Any)
    {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

