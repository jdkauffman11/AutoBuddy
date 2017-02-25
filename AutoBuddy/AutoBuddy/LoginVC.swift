//
//  LoginVC.swift
//  AutoBuddy
//
//  Created by Jordan Kauffman on 1/18/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import UIKit
import Firebase

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
    
    @IBAction func Login(_ sender: Any)
    {
        dismissKeyboard()
        loginUser()
    }
    
    @IBAction func SignUp(_ sender: Any)
    {
        dismissKeyboard()
        addUser()
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addUser()
    {
        if(emailBox.text?.isEmpty)!
        {
            return
        }
        else if(!((emailBox.text?.contains("@"))! && (emailBox.text?.contains(".com"))!))
        {
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: emailBox.text!, password: passwordBox.text!, completion:
            { (user, error) in
                if error != nil
                {
                    if let errorCode = FIRAuthErrorCode(rawValue: (error?._code)!)
                    {
                        
                        switch (errorCode)
                        {
                            
                        case .errorCodeEmailAlreadyInUse:
                            
                            let alert = UIAlertController(title: "Email already exists",
                                                          message:"Please use a different email", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                            self.present(alert, animated: true){}
                            break
                        case .errorCodeInvalidEmail:
                            let alert = UIAlertController(title: "Invalid email",
                                                          message:"Please enter valid email.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                            self.present(alert, animated: true){}
                            break
                        case .errorCodeNetworkError:
                            let alert = UIAlertController(title: "Network Error",
                                                          message:"Net-doesn't-work.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                            self.present(alert, animated: true){}
                            break
                        default:
                            let alert = UIAlertController(title: "An error occurred",
                                                          message:"Please try again later.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                            self.present(alert, animated: true){}
                            break
                        }
                        
                    }
                    
                }
                else
                {
                    self.performSegue(withIdentifier: "successfulLogin", sender: nil)
                }
                
        })
    }
    
    
    private func loginUser()
    {
        if(emailBox.text?.isEmpty)!
        {
            return
        }
        else if(!((emailBox.text?.contains("@"))! && (emailBox.text?.contains(".com"))!))
        {
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: emailBox.text!, password: passwordBox.text!) { (user, error) in
            if error != nil
            {
                if let errorCode = FIRAuthErrorCode(rawValue: (error?._code)!)
                {
                    
                    switch (errorCode)
                    {
                        
                    case .errorCodeEmailAlreadyInUse:
                        
                        let alert = UIAlertController(title: "Email already exists",
                                                      message:"Please use a different email", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    case .errorCodeUserNotFound:
                        let alert = UIAlertController(title: "User not found",
                                                      message:"Please create an account.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    case .errorCodeInvalidEmail:
                        let alert = UIAlertController(title: "Invalid email",
                                                      message:"Please enter valid email.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    case .errorCodeWrongPassword:
                        let alert = UIAlertController(title: "Invalid Password",
                                                      message:"Please enter a valid password.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    case .errorCodeNetworkError:
                        let alert = UIAlertController(title: "Network Error",
                                                      message:"Net-doesn't-work.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    case .errorCodeInternalError:
                        let alert = UIAlertController(title: "Unknown Error Occurred",
                                                      message:"Your guess is as good as mine.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    default:
                        let alert = UIAlertController(title: "An error occurred",
                                                      message:"Please try again later.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                        self.present(alert, animated: true){}
                        break
                    }
                    
                }
                
            }
            else
            {
                self.performSegue(withIdentifier: "successfulLogin", sender: nil)
            }
            
        }
        
    }
}

