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
    static let bearerToken = "bearerToken" /// API documentation has it as "token"...??
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var myHowToLabel: UILabel!
    @IBOutlet weak var numOfHowTos: UILabel!
    @IBOutlet weak var myBookmarks: UILabel!
    @IBOutlet weak var numOfBookmarks: UILabel!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.string(forKey: .bearerToken) == nil {
            performSegue(withIdentifier: "Onboarding", sender: self)
        }
        
        profileNameLabel.text = "Hi \(user?.username)!"
//        numOfHowTos.text = instructor.guides.count -- something like this
//        numOfBookmarks
    }
    
     @IBAction func unwindToProfile(unwindSegue: UIStoryboardSegue) {
        
    }
    
    @IBAction func exploreHowTosTapped(_ sender: UIButton) {
        
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
