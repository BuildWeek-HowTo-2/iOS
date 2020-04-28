//
//  APIController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
    case badUrl
    case noIdentifier
}

class APIController {
    
   // TODO: Add CoreData code
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    typealias CompletionHandlerTitles = (Result<[Tutorial], NetworkError>) -> Void
    typealias CompletionHandlerSummaries = (Result<Tutorial, NetworkError>) -> Void
    
    // TODO: fill in URL path and components
    private let baseURL = URL(string: "https://how2s.herokuapp.com")!
    private(set) var tutorials: [Tutorial] = []
    
    var bearer: Bearer?
    
    // create signUp
    func userSignUp(with user: User, completion: @escaping (Error?) -> ()) {
        
        let userSignUpURL = baseURL.appendingPathComponent("/api/users/register")
        var request = URLRequest(url: userSignUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                return completion(NSError(domain: response.description, code: response.statusCode, userInfo: nil))
            }
            
            if let error = error {
                return completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    func instructorSignUp(with user: User, completion: @escaping (Error?) -> ()) {
        
        let userSignUpURL = baseURL.appendingPathComponent("/api/instructors/register")
        var request = URLRequest(url: userSignUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                return completion(NSError(domain: response.description, code: response.statusCode, userInfo: nil))
            }
            
            if let error = error {
                return completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    // create signIn
    func userLogin(with user: User, completion: @escaping (Error?) -> ()) {
        
        let userLoginURL = baseURL.appendingPathComponent("/api/users/login")
        
        var request = URLRequest(url: userLoginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                return completion(NSError(domain: response.description, code: response.statusCode, userInfo: nil))
            }
            
            if let error = error {
                return completion(error)
            }
            
            guard let data = data else {
                return completion(NSError(domain: "Data not found", code: 99, userInfo: nil)) /// right code?
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
                completion(nil)
            } catch {
                NSLog("Error decoding bearer object: \(error)")
                return completion(error)
            }
        }.resume()
    }
    
    func instructorLogin(with user: User, completion: @escaping (Error?) -> ()) {
        
        let userLoginURL = baseURL.appendingPathComponent("/api/instructors/login")
        
        var request = URLRequest(url: userLoginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                return completion(NSError(domain: response.description, code: response.statusCode, userInfo: nil))
            }
            
            if let error = error {
                return completion(error)
            }
            
            guard let data = data else {
                return completion(NSError(domain: "Data not found", code: 99, userInfo: nil)) /// right code?
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
                completion(nil)
            } catch {
                NSLog("Error decoding bearer object: \(error)")
                return completion(error)
            }
        }.resume()
    }
    
    // create fetching tutorials method
    func fetchAllTutorialTitles(completion: @escaping CompletionHandlerTitles = { _ in }) {
        
        let allTutorialsURL = baseURL.appendingPathComponent("api/tutorials")
        var request = URLRequest(url: allTutorialsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving tutorial title data: \(error)")
                return completion(.failure(.otherError))
            }
            
            guard let data = data else {
                return completion(.failure(.badData))
            }
            
            let decoder = JSONDecoder()
            do {
                let titles = try decoder.decode([Tutorial].self, from: data)
                self.tutorials = titles
                completion(.success(titles))
            } catch {
                NSLog("Error decoding title objects: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    // create fetching tutorial Details
    func fetchTutorialDetails(for tutorialTitle: String, completion: @escaping CompletionHandlerSummaries = { _ in }) {
        
        let tutorialURL = baseURL.appendingPathComponent("tutorials/\(tutorialTitle)")
        
        var request = URLRequest(url: tutorialURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving tutorial summary data: \(error)")
                return completion(.failure(.otherError))
            }
            
            guard let data = data else {
                NSLog("Sever responded with no data to decode")
                return completion(.failure(.badData))
            }
            
            let decoder = JSONDecoder()
            do {
                let tutorial = try decoder.decode(Tutorial.self, from: data)
                completion(.success(tutorial))
            } catch {
                NSLog("Error decoding tutorial object \(tutorialTitle): \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    // create createTutorial method
    func createTutorial(tutorial: Tutorial, completion: @escaping CompletionHandler = { _ in }) {
        ///// guard let id code
        
        let requestURL = baseURL.appendingPathComponent("").appendingPathExtension("json") //// need component
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue /// using put rather than post??
       
        //// JSONEncoder with coredata
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error sending task to server: \(error)")
                return completion(.failure(.otherError))
            }
            completion(.success(true))
        }.resume()
    }
    
    func deleteTutorial(tutorial: Tutorial, completion: @escaping CompletionHandler = { _ in }) {
        ///// guard let id code
        
        let requestURL = baseURL.appendingPathComponent("").appendingPathExtension("json") /// need component
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error deleting task from server: \(error)")
                return completion(.failure(.otherError))
            }
            completion(.success(true))
        }.resume()
    }
    
    // TODO: build out CoreData methods
    private func updateTutorials() {
        
    }
    
    private func update() {
        
    }
}
