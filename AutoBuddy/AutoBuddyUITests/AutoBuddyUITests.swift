//
//  AutoBuddyUITests.swift
//  AutoBuddyUITests
//
//  Created by Jordan Kauffman on 4/10/17.
//  Copyright © 2017 Jordan Kauffman. All rights reserved.
//

import XCTest

class AutoBuddyUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testLogin() {
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        
//        let app = XCUIApplication()
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        emailTextField.typeText("a@b.com")
//        
//        let passwordSecureTextField = app.secureTextFields["Password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("asdfgh")
//        app.otherElements.containing(.image, identifier:"road.png").element.tap()
//        app.buttons["Login"].tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
//        
//    }
    
//    func testSignUp() {
//        
//        let app = XCUIApplication()
//        let emailTextField = app.textFields["Email"]
//        emailTextField.tap()
//        emailTextField.typeText("x@a.com")
//        
//        let passwordSecureTextField = app.secureTextFields["Password"]
//        passwordSecureTextField.tap()
//        passwordSecureTextField.typeText("qwerty")
//        app.buttons["Sign Up"].tap()
//        
//    }
    
    func testAddingTwoVehicles()
    {
        
        let app = XCUIApplication()
        let yearTextField = app.textFields["Year"]
        yearTextField.tap()
        yearTextField.typeText("2010")
        
        let makeTextField = app.textFields["Make"]
        makeTextField.tap()
        makeTextField.tap()
        makeTextField.typeText("ford")
        
        let modelTextField = app.textFields["Model"]
        modelTextField.tap()
        modelTextField.tap()
        modelTextField.typeText("mustang")
        app.buttons["loadTrimsButton"].tap()
        app.tables.staticTexts["GT Premium 2dr Convertible (4.6L 8cyl 5M)"].tap()
        app.buttons["nextButton"].tap()
        
        yearTextField.tap()
        yearTextField.typeText("2010")
        
        makeTextField.tap()
        makeTextField.tap()
        makeTextField.typeText("chevrolet")
        
        modelTextField.tap()
        modelTextField.tap()
        modelTextField.typeText("camaro")
        app.buttons["loadTrimsButton"].tap()
        app.tables.staticTexts["1SS 2dr Coupe (6.2L 8cyl 6M)"].tap()
        app.buttons["nextButton"].tap()

    }
    
}
