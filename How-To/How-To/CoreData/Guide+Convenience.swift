//
//  Tutorial+Convenience.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation
import CoreData

extension Guide {
    @discardableResult convenience init?(tutorial: Tutorial, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)

        self.id = Int16(tutorial.id ?? 0)
        self.instructor_id = Int16(tutorial.instructor_id ?? 0)
        self.likes = Int16(tutorial.likes ?? 0)
        self.summary = tutorial.summary
        self.title = tutorial.title
        // self.guideSteps = tutorial.tutorialSteps
    }
}
