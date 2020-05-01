//
//  OnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class UserOnboardingViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var getStartedButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.layer.cornerRadius = 8
    }
    
    // MARK: - IBActions
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
