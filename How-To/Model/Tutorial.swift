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
    let title: String
    let summary: String
//    let tutorialSteps: TutorialSteps
    let likes: Int = 0
    let instructor_id: Int
}

struct TutorialSteps: Codable {
    let stepTitle: String
    let stepNumber: Int
}
