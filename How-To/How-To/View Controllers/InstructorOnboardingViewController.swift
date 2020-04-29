//
//  InstructorOnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class InstructorOnboardingViewController: UIViewController {

    @IBOutlet weak var welcomeInstructorImage: UIImage!
    @IBOutlet weak var welcomeInstructorLabel: UILabel!
    @IBOutlet weak var welcomeInstructorText: UITextView!
    @IBOutlet weak var instructorPageTwoImage: UIImage!
    @IBOutlet weak var instructorPageTwoLabel: UILabel!
    @IBOutlet weak var instructorPageTwoText: UITextView!
    @IBOutlet weak var instructorPageThreeImage: UIImage!
    @IBOutlet weak var instructorPageThreeLabel: UILabel!
    @IBOutlet weak var instructorPageThreeText: UITextView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func updateViews() {
        welcomeInstructorLabel.text = "Welcome to HowTo."
        welcomeInstructorText.text = "The new world of community knowledge is here."
        instructorPageTwoLabel.text = "Know How"
        instructorPageTwoText.text = "HowTo makes it easy to create and share your wisdom through HowTo guides!"
        instructorPageThreeLabel.text = "Bookmark"
        instructorPageThreeText.text = "HowTo makes it easy to keep track of those hacks and home improvement instructionals with bookmarks."
        
        
    }
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
