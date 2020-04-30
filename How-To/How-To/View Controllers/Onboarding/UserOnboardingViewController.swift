//
//  OnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class UserOnboardingViewController: UIViewController {
    
    var userType: UserType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func welcomeNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "DiscoverSegue", sender: sender)
    }
    
    @IBAction func pageTwoNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "UserBookmarkSegue", sender: sender)
    }
    
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}
