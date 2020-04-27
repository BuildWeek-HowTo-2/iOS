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
    let summary: String?
    let likes: Int = 0
    let instructor_id: Int
}
