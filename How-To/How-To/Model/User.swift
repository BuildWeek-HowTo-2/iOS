//
//  User.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.id = 0
    }
}

struct UserReturned: Codable {
    var id: Int
    var token: String
}
