//
//  How_ToUITests.swift
//  How-ToUITests
//
//  Created by Wyatt Harrell on 4/29/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import XCTest
@testable import How_To

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
    
    private var bookmarkButton: XCUIElement {
        app.buttons["BookmarkVC.BookmarkButton"]
    }
    
    private var signUpButton: XCUIElement {
        app.buttons["Onboarding.SignUpButton"]
    }
    
    private var createPost: XCUIElement {
        app.buttons["ProfileVC.CreatePost"]
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
    
    /*
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
    
        /*
         USER MUST BE LOGGED OUT FOR THIS TO PASS
        */

        setUp()
        
        app.launch()
        app.wait(for: .unknown, timeout: 2)
        app.segmentedControls.buttons["Instructor"].tap()
        usernameTextField.tap()
        usernameTextField.typeText("Jasmine")
        
        app.secureTextFields["Onboarding.PasswordTextField"].tap()
        app.secureTextFields["Onboarding.PasswordTextField"].typeText("testing123")
        app.segmentedControls.buttons["Login"].tap()
        
        signUpButton.tap()
        app.wait(for: .unknown, timeout: 2)

        app.staticTexts["Jasmine"].tap()
    }
     */
     
    /*
     USER MUST BE LOGGED IN FOR THESE TO PASS
    */
    
    func testSearching() throws {
        app.launch()
        app.tabBars.buttons["Tutorials"].tap()
        app.searchFields["Search by instructor id:"].tap()
        app.typeText("3\n")
    }
    
    func testFetchingTutorials() throws {
        app.launch()
        app.tabBars.buttons["Tutorials"].tap()
        app.swipeDown()
    }
    
    func testAddingSteps() throws {
        app.launch()
        createPost.tap()
        // swiftlint:disable line_length
        let addStepStaticText = XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["+ Add Step"]/*[[".buttons[\"+ Add Step\"].staticTexts[\"+ Add Step\"]",".staticTexts[\"+ Add Step\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        // swiftlint:enable line_length
        addStepStaticText.tap()
        addStepStaticText.tap()
        addStepStaticText.tap()
    }
    
    func testAddingStepsAndTestDynamicScrollView() throws {
        app.launch()
        createPost.tap()
        
        let addStepStaticText = app.staticTexts["+ Add Step"]
        addStepStaticText.tap()
        addStepStaticText.tap()
        addStepStaticText.tap()
        addStepStaticText.tap()
        addStepStaticText.tap()
        app.swipeUp()
    }
    
    func testDeletingRecord() throws {
        app.launch()
        app.tabBars.buttons["Tutorials"].tap()
        app.tap()
        app.tap()
        app.navigationBars["How-To"].buttons["Delete"].tap()
        app.sheets["Delete Tutorial"].scrollViews.otherElements.buttons["Delete Tutorial"].tap()
    }

}
