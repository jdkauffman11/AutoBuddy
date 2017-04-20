//
//  AutoBuddyTests.swift
//  AutoBuddyTests
//
//  Created by Jordan Kauffman on 4/10/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import XCTest

class AutoBuddyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
//    func testLogin() {
//        // This is an example of a performance test case.
//        FIRAuth.auth()?.signIn(withEmail: emailBox.text!, password: passwordBox.text!) { (user, error) in
//            if error != nil
//            {
//                if let errorCode = FIRAuthErrorCode(rawValue: (error?._code)!)
//                {
//                    
//                    switch (errorCode)
//                    {
//                        
//                    case .errorCodeEmailAlreadyInUse:
//                        
//                        let alert = UIAlertController(title: "Email already exists",
//                                                      message:"Please use a different email", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    case .errorCodeUserNotFound:
//                        let alert = UIAlertController(title: "User not found",
//                                                      message:"Please create an account.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    case .errorCodeInvalidEmail:
//                        let alert = UIAlertController(title: "Invalid email",
//                                                      message:"Please enter valid email.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    case .errorCodeWrongPassword:
//                        let alert = UIAlertController(title: "Invalid Password",
//                                                      message:"Please enter a valid password.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    case .errorCodeNetworkError:
//                        let alert = UIAlertController(title: "Network Error",
//                                                      message:"Net-doesn't-work.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    case .errorCodeInternalError:
//                        let alert = UIAlertController(title: "Unknown Error Occurred",
//                                                      message:"Your guess is as good as mine.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    default:
//                        let alert = UIAlertController(title: "An error occurred",
//                                                      message:"Please try again later.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
//                        self.present(alert, animated: true){}
//                        break
//                    }
//                    
//                }
//                
//            }
//            else
//            {
//                self.performSegue(withIdentifier: "successfulLogin", sender: nil)
//            }
//            
//        }
//        
//    }
    
}
