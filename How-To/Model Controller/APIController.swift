//
//  APIController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation
import UIKit

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
}

class APIController {
    
    // TODO: fill in URL path and components
    private let baseURL = URL(string: "")! /// need url
    
    var bearer: Bearer?
    
    // create signUp
    func signUp(with user: User, completion: @escaping (Error?) -> ()) {
        
        let signUpURL = baseURL.appendingPathComponent("") ///// need components
        var request = URLRequest(url: signUpURL)
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
    func signIn(with user: User, completion: @escaping (Error?) -> ()) {
        
        let signInURL = baseURL.appendingPathComponent("") ///// need components
        
        var request = URLRequest(url: signInURL)
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
    
    
    // create tutorial directions?
}
