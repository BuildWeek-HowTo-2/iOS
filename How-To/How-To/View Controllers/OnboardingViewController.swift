//
//  OnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var welcomeStackView: UIStackView!
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var pageTwoImage: UIImageView!
    @IBOutlet weak var pageTwoLabel: UILabel!
    @IBOutlet weak var pageTwoText: UILabel!
    @IBOutlet weak var pageThreeImage: UIImageView!
    @IBOutlet weak var pageThreeLabel: UILabel!
    @IBOutlet weak var pageThreeText: UILabel!
    
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
