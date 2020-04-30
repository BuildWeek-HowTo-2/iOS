//
//  How_ToUITests.swift
//  How-ToUITests
//
//  Created by Wyatt Harrell on 4/29/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import XCTest
import How_To

class HowToUITests: XCTestCase {

    private var app: XCUIApplication {
        XCUIApplication()
    }

    private var usernameLabel: XCUIElement {
        app.staticTexts["HomeVC.UsernameLabel"]
    }
    
    private var userTypeLabel: XCUIElement {
        app.staticTexts["HomeVC.UserTypeLabel"]
    }

    private var usernameTextField: XCUIElement {
        app.textFields["Onboarding.UsernameTextField"]
    }
    
    private var passwordTextField: XCUIElement {
        app.textFields["Onboarding.PasswordTextField"]
    }
    
    private var verifyPasswordTextField: XCUIElement {
        app.textFields["Onboarding.VerifyPasswordTextField"]
    }
    
    private var signUpButton: XCUIElement {
        app.buttons["Onboarding.SignUpButton"]
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.set(nil, forKey: "username")

    }
    
    
    func testLoginAsUser() throws {
    
        /*
         USER MUST BE LOGGED OUT FOR THIS TO PASS
        */

        setUp()
        
        app.launch()
        app.wait(for: .unknown, timeout: 2)
        usernameTextField.tap()
        usernameTextField.typeText("Lilly")
        
        app.secureTextFields["Onboarding.PasswordTextField"].tap()
        app.secureTextFields["Onboarding.PasswordTextField"].typeText("testing123")
        app.segmentedControls.buttons["Login"].tap()
        
        signUpButton.tap()
        app.wait(for: .unknown, timeout: 2)

        app.staticTexts["Lilly"].tap()
        app.staticTexts["User"].tap()
    }
    
    func testLoginAsInstructor() throws {
        let app = XCUIApplication()
        app.launch()

    }
    
    func testSignInAsUser() throws {
        let app = XCUIApplication()
        app.launch()

    }
    
    func testSignInAsInstrucor() throws {
        let app = XCUIApplication()
        app.launch()

    }
    

    
    func testViewingTutorial() throws {
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
