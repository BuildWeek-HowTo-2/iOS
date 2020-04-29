//
//  Tutorial.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

struct Tutorial: Codable {
    let id: Int?
    let title: String
    let summary: String
    var tutorialSteps: [TutorialSteps]?
    let likes: Int
    let instructor_id: Int
}

struct TutorialSteps: Codable {
    let instructions: String
    let step_number: Int
}
