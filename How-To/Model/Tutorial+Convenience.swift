//
//  Tutorial+Convenience.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation
import CoreData

extension GuideSteps {
    // child to parent relationship established
    convenience init?(guide: Guide, instructions: String, stepNumber: Int16, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.guide = guide
        self.instructions = instructions
        self.stepNumber = stepNumber
    }
}
