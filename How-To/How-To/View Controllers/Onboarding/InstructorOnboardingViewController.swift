//
//  InstructorOnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class InstructorOnboardingViewController: UIViewController {
    
    var userType: UserType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func welcomeNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShareSegue", sender: sender)
    }
    
    @IBAction func pageTwoNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "GetInspiredSegue", sender: sender)
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
