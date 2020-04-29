//
//  LoginViewController.swift
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

enum UserType: String {
    case users
    case instructors
}

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var verifyStackView: UIStackView!
    
    // MARK: - Properties
    var apiController = APIController()
    #warning("Needs to be sent in through dependency injection")
    
    var userType = UserType.users
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.becomeFirstResponder()
        loginButton.layer.cornerRadius = 8
    }
    
    @IBAction func submit(_ sender: UIButton) {
            if loginType == .signUp {
                guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let verifyPassword = verifyTextField.text, !verifyPassword.isEmpty else { return }
                let user = User(username: email, password: password)
                
                apiController.signUp(with: user, userType: userType, completion: { error in
                    if let error = error {
                        NSLog("Error occurred during sign up: \(error)")
                        
                        /*
                         
                         SHOW ALERT FOR INVALID SIGNUP HERE
                         
                        */
                        
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please login", preferredStyle: .alert)
                            
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true)
                            self.loginType = .login
                            self.usernameTextField.becomeFirstResponder()
                        }
                    }
                })
            } else if loginType == .login {
                guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
                let user = User(username: email, password: password)
                
                apiController.login(with: user, userType: userType, completion: { error in
                    if let error = error {
                        NSLog("Error occured during sign in: \(error)")
                        
                        /*
                         
                         SHOW ALERT FOR INVALID LOGIN HERE
                         
                        */
                        
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                })
            }
    }
    
    @IBAction func loginTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            verifyStackView.isHidden = false
            loginButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .login
            verifyStackView.isHidden = true
            loginButton.setTitle("Login", for: .normal)
            // TODO: need to add forgotPassword label
        }
    }
    
    @IBAction func userTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userType = .users
        } else {
            userType = .instructors
        }
    }
}


