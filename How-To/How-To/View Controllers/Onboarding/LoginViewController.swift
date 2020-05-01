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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var verifyTextField: UITextField!
    @IBOutlet private weak var userTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var loginTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var verifyStackView: UIStackView!
    
    // MARK: - Properties
    var apiController = APIController() //TODO: NEED TO SEND THROUGH DEPENDENCY INJECTION
    var userType = UserType.users
    var loginType = LoginType.signUp
   
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        verifyTextField.delegate = self
        setupViews()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        loginButton.layer.cornerRadius = 8
    }

    // MARK: - IBActions
    @IBAction func submit(_ sender: UIButton) {
        
        if loginType == .signUp {
            guard let email = usernameTextField.text,
                !email.isEmpty,
                let password = passwordTextField.text,
                !password.isEmpty,
                let verifyPassword = verifyTextField.text,
                !verifyPassword.isEmpty else { return }
            let user = User(username: email, password: password)
            
            apiController.signUp(with: user, userType: userType, completion: { error in
                if let error = error {
                    NSLog("Error occurred during sign up: \(error)")
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Error Signing Up", message: "Please try again.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Sign Up", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        
                        //TODO: MISSING ALERT FOR NON-MATHCING PASSWORDS
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        UserDefaults.standard.set(email, forKey: .username)
                        UserDefaults.standard.set(self.userType.rawValue, forKey: .userType)
                        
                        if self.userType == .users {
                            self.performSegue(withIdentifier: "UserOnboardingSegue", sender: self)
                        } else {
                            self.performSegue(withIdentifier: "InstructorOnboardingSegue", sender: self)
                        }

                    }
                }
            })
        } else if loginType == .login {
            guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
            let user = User(username: email, password: password)
            
            apiController.login(with: user, userType: userType, completion: { error in
                if let error = error {
                    NSLog("Error occured during sign in: \(error)")
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Error Logging In", message: "Please try again.", preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        
                        UserDefaults.standard.set(email, forKey: .username)
                        UserDefaults.standard.set(self.userType.rawValue, forKey: .userType)

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
        }
    }
    
    @IBAction func userTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userType = .users
        } else {
            userType = .instructors
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        //TODO: NEED TO ADD ALERT HERE
    }
    
}
