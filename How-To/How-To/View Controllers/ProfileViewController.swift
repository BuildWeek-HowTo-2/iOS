//
//  ProfileViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    static let bearerToken = "bearerToken"
    static let username = "username"
}

class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        if let username = UserDefaults.standard.string(forKey: .username) {
            self.navigationItem.title = "Welcome, \(username.capitalized)"
        } else {
            performSegue(withIdentifier: "Onboarding", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let username = UserDefaults.standard.string(forKey: .username) {
            self.navigationItem.title = "Welcome, \(username.capitalized)"
        }
    }
    
    private func setupViews() {
        logoutButton.layer.cornerRadius = 8
    }
    
    // MARK: - IBActions
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: .username)
        performSegue(withIdentifier: "Onboarding", sender: self)
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
