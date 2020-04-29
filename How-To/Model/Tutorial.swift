//
//  Tutorial.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct Tutorial: Codable {
    let id: Int
    var title: String
    var summary: String
    var tutorialSteps: [TutorialSteps]?
    var likes: Int
    let instructor_id: Int
}

struct TutorialSteps: Codable {
    var instructions: String
    let step_number: Int
}
