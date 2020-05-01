//
//  How_ToTests.swift
//  How-ToTests
//
//  Created by Wyatt Harrell on 4/29/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import XCTest
@testable import How_To

class HowToTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingTutorials() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Fetching Tutorials")
        
        apiController.fetchAllTutorialTitles { result in
            do {
                let tutorials = try result.get()
                XCTAssertNotNil(tutorials)
            } catch {
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testSearchingTutorials() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Searching Tutorials")

        apiController.searchTutorialsByID(for: "1") { result in
            do {
                let tutorials = try result.get()
                XCTAssertNotNil(tutorials)
            } catch {
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testUserLogin() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "User Login")
        
        apiController.login(with: User(username: "Lilly", password: "testing123"), userType: .users) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testUserInvalidLogin() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Invalid User Login")
        
        apiController.login(with: User(username: "Lilly", password: "ergigerh"), userType: .users) { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testUserSignup() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "User Signup")
        
        apiController.signUp(with: User(username: "Lilly2", password: "testing123"), userType: .users) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInstructorLogin() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Instructor Login")
        
        apiController.login(with: User(username: "Jasmine", password: "testing123"), userType: .instructors) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testInstructorInvalidLogin() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Instructor Invalid Login")
        
        apiController.login(with: User(username: "Jasmine", password: "ergigerh"), userType: .instructors) { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testInstructorSignup() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Instructor Signup")
        
        apiController.signUp(with: User(username: "Lilly2", password: "testing123"), userType: .instructors) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchingTutorialSteps() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Fetching Steps")
        
    }
}
