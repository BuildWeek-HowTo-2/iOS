//
//  Tutorial.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct Tutorial: Codable {
    let username: String?
    let id: Int?
    var title: String
    var summary: String

    var tutorialSteps: [TutorialSteps]?
    var likes: Int?
    let instructor_id: Int?
}

struct TutorialSteps: Codable {
    var instructions: String
    let step_number: Int
}

// This was just for me checking my sanity when I was getting HTML back as a response from the backend
struct Tut: Codable {
    var title: String
    var summary: String
    var instructor_id: Int
}


struct Test: Codable {
    var id: Int
    var step_number: Int
    var instructions: String
    var tutorial_id: Int
}
