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
    
    func testFetchingTutorialSteps() {
        let apiController = APIController()
        let expectationTuts = XCTestExpectation(description: "Fetching Tutorials")
        let expectationSteps = XCTestExpectation(description: "Fetching Steps")
        
        var tuts: [Tutorial] = []
        
        apiController.fetchAllTutorialTitles { result in
            do {
                let tutorials = try result.get()
                XCTAssertNotNil(tutorials)
                tuts = tutorials
            } catch {
                XCTAssertNil(error)
            }
            expectationTuts.fulfill()
        }
        wait(for: [expectationTuts], timeout: 10)
        
        apiController.fetchTutorialSteps(for: tuts[0]) { result in
            do {
                let tutorialSteps = try result.get()
                XCTAssertNotNil(tutorialSteps)
            } catch {
                XCTAssertNil(error)
            }
            expectationSteps.fulfill()
        }
        wait(for: [expectationSteps], timeout: 10)
    }
    
    func testDeletingTutorial() {
        let apiController = APIController()
        let expectationTuts = XCTestExpectation(description: "Fetching Tutorials")
        let expectationDelete = XCTestExpectation(description: "Deleting Tutorial")
        
        var tuts: [Tutorial] = []
        
        apiController.fetchAllTutorialTitles { result in
            do {
                let tutorials = try result.get()
                XCTAssertNotNil(tutorials)
                tuts = tutorials
            } catch {
                XCTAssertNil(error)
            }
            expectationTuts.fulfill()
        }
        wait(for: [expectationTuts], timeout: 10)
        
        apiController.deleteTutorial(tutorial: tuts[0]) { result in
            do {
                let tutorialDeletedBool = try result.get()
                XCTAssertTrue(tutorialDeletedBool)
            } catch {
                XCTAssertNil(error)
            }
            expectationDelete.fulfill()
        }
        wait(for: [expectationDelete], timeout: 10)
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
    
    func testCreatingTutorial() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Creating Tutorial")
        
        apiController.createTutorial(tutorial: Tut(title: "Test", summary: "Testing", instructor_id: 3), completion: { tutorial, error in
            XCTAssertNotNil(tutorial)
            XCTAssertNil(error)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testCreatingTutorialSteps() {
        let apiController = APIController()
        let expectation2 = XCTestExpectation(description: "Creating Tutorial Steps")
        
        apiController.createTutorialSteps(tutorialSteps: TutorialSteps(instructions: "", step_number: 3), for: 4, completion: { (test, error) in
            XCTAssertNil(error)
        })
        
        wait(for: [expectation2], timeout: 150)
        
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

    /*
    func testInstructorSignup() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "Instructor Signup")
        
        apiController.signUp(with: User(username: "Lilly\(Int.random(in: 0...100))", password: "testing123"), userType: .instructors) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testUserSignup() {
        let apiController = APIController()
        let expectation = XCTestExpectation(description: "User Signup")
        
        apiController.signUp(with: User(username: "Lilly\(Int.random(in: 0...100))", password: "testing123"), userType: .users) { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
     */

}
