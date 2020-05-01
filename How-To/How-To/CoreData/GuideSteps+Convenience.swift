//
//  GuideSteps+Convenience.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/30/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation
import CoreData

extension GuideSteps {
    @discardableResult convenience init?(tutorialSteps: TutorialSteps, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.instructions = tutorialSteps.instructions
        self.stepNumber = Int16(tutorialSteps.step_number)
    }
}
