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
        
    // MARK: - Properties
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    typealias CompletionHandlerTitles = (Result<[Tutorial], NetworkError>) -> Void
    typealias CompletionHandlerSummaries = (Result<[TutorialSteps], NetworkError>) -> Void
    
    private let baseURL = URL(string: "https://how2s.herokuapp.com")!
    
    private(set) var tutorials: [Tutorial] = []
    var bearer: Bearer?
    
    /// SignUp
    /// - Parameters:
    ///   - user: User will be used to pass username and password
    ///   - userType: userType is used to determine type of user or instructor
    ///   - completion: nil
    func signUp(with user: User, userType: UserType, completion: @escaping (Error?) -> Void) {
        let userSignUpURL = baseURL.appendingPathComponent("/api/\(userType.rawValue)/register")
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
        
            //TODO: UserDefaults.standard.set(returnedUser.id, forKey: .userid)
            
            if let error = error {
                return completion(error)
            }
            completion(nil)
        }.resume()
    }
    
    /// Login
    /// - Parameters:
    ///   - user: User will be used to pass username and password
    ///   - userType: userType is used to determine type of user or instructor
    func login(with user: User, userType: UserType, completion: @escaping (Error?) -> Void) {
        let userLoginURL = baseURL.appendingPathComponent("/api/\(userType.rawValue)/login")
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
                let returnedUser = try decoder.decode(UserReturned.self, from: data)
                UserDefaults.standard.set(returnedUser.id, forKey: .userid)
                completion(nil)
            } catch {
                NSLog("Error decoding bearer object: \(error)")
                return completion(error)
            }
        }.resume()
    }
    
    /// Fetch all tutorial titles
    /// - Parameters:
    func fetchAllTutorialTitles(completion: @escaping CompletionHandlerTitles = { _ in }) {
        let allTutorialsURL = baseURL.appendingPathComponent("api/tutorials")
        var request = URLRequest(url: allTutorialsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
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
    
    /// Fetch all tutorial steps
    /// - Parameters:
    ///   - tutorial: Used to get tutorial id
    func fetchTutorialSteps(for tutorial: Tutorial, completion: @escaping CompletionHandlerSummaries = { _ in }) {
        guard let tutorialID = tutorial.id else { return }
        let tutorialURL = baseURL.appendingPathComponent("api/tutorials/\(tutorialID)/directions")
        var request = URLRequest(url: tutorialURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
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
                let tutorialSteps = try decoder.decode([TutorialSteps].self, from: data)
                completion(.success(tutorialSteps))
            } catch {
                NSLog("Error decoding tutorial object \(tutorialID): \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    /// Delete a tutorial
    /// - Parameters:
    ///   - tutorial: Used to get tutorial ID
    func deleteTutorial(tutorial: Tutorial, completion: @escaping CompletionHandler = { _ in }) {
        guard let tutorialID = tutorial.id else { return }
        let tutorialURL = baseURL.appendingPathComponent("api/tutorials/\(tutorialID)")
        var request = URLRequest(url: tutorialURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error deleting task from server: \(error)")
                return completion(.failure(.otherError))
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Response Error - Cannot Delete ")
                return completion(.failure(.otherError))
            }
            
            guard let data = data else {
                NSLog("Sever responded with no data to decode")
                return completion(.failure(.badData))
            }
            
            let decoder = JSONDecoder()
            do {
                let deleteSuccess = try decoder.decode(String.self, from: data)
                NSLog("DATA RETURNED FROM SERVER ::: \(deleteSuccess)")
                completion(.success(true))
            } catch {
                NSLog("Error decoding response from server \(tutorialID): \(error)")
                completion(.failure(.noDecode))
            }
    
        }.resume()
    }
    
    /// Search tutorial by ID
    /// - Parameters:
    ///   - tutorialId: tutorialId
    func searchTutorialsByID(for tutorialId: String, completion: @escaping CompletionHandlerTitles = { _ in }) {
        let tutorialURL = baseURL.appendingPathComponent("api/tutorials/\(tutorialId)")
        var request = URLRequest(url: tutorialURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
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
                let titles = try decoder.decode([Tutorial].self, from: data)
                self.tutorials = titles
                completion(.success(titles))
            } catch {
                NSLog("Error decoding tutorial object \(tutorialId): \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func createTutorial(tutorial: Tut, completion: @escaping (Tutorial?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("api/tutorials")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(tutorial)
            let str = String(decoding: jsonData, as: UTF8.self)
            print("DATA: \(str)")
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(nil, error)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error sending task to server: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("Sever responded with no data to decode")
                return completion(nil, error)
            }
            
            let decoder = JSONDecoder()
            do {
                let tut = try decoder.decode(Tutorial.self, from: data)
                completion(tut, nil)
            } catch {
                NSLog("Error decoding tutorial object: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    func createTutorialSteps(tutorialSteps: TutorialSteps, for id: Int, completion: @escaping (Tutorial?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("api/tutorials/\(id)/directions")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(tutorialSteps)
            let str = String(decoding: jsonData, as: UTF8.self)
            print("DATA: \(str)")
            request.httpBody = jsonData
        } catch {
            NSLog("Error encoding user object: \(error)")
            return completion(nil, error)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error sending task to server: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("Sever responded with no data to decode")
                return completion(nil, error)
            }
            
            let decoder = JSONDecoder()
            do {
                let tut = try decoder.decode(Tutorial.self, from: data)
                completion(tut, nil)
            } catch {
                NSLog("Error decoding tutorial object: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
}
