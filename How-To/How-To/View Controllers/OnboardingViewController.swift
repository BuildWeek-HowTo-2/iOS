//
//  OnboardingViewController.swift
//  How-To
//
//  Created by Nichole Davidson on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case login
}

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    
    var apiController: APIController?
    var loginType = LoginType.signUp
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let verifyPassword = verifyTextField.text,
            !verifyPassword.isEmpty,
            password == verifyPassword {
            let user = User(username: email, password: password)
            
            if loginType == .signUp {
                apiController?.userSignUp(with: user, completion: { error in
                    if let error = error {
                        NSLog("Error occurred during sign up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign Up Successful", message: "", preferredStyle: .alert)
                            
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true)
                        }
                    }
                })
            } else {
                apiController?.userLogin(with: user, completion: { error in
                    if let error = error {
                        NSLog("Error occured during sign in: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil) ///// Dismiss where?
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            loginButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .login
            verifyTextField.isHidden = true
            lineView.isHidden = true
            loginButton.setTitle("Login", for: .normal)
            // TODO: need to add forgotPassword label
        }
    }
}


