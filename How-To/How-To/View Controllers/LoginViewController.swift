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
        self.hideKeyboardWhenTappedAround()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        verifyTextField.delegate = self
    }
    
    func setUserDefaults(username: UITextField) {
        guard let username = username.text else { return }
        UserDefaults.standard.set(username, forKey: "username")
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if loginType == .signUp {
            guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let verifyPassword = verifyTextField.text, !verifyPassword.isEmpty else { return }
            let user = User(username: email, password: password)
            
            apiController.signUp(with: user, userType: userType, completion: { error in
                if let error = error {
                    NSLog("Error occurred during sign up: \(error)")
                    
                    let alertController = UIAlertController(title: "Error Signing Up", message: "Please try again.", preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Sign Up", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign Up Successful", message: "Thank you!", preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        self.loginType = .login
                        self.usernameTextField.becomeFirstResponder()
                        self.setUserDefaults(username: self.usernameTextField)
                       
                    }
                }
            })
        } else if loginType == .login {
            guard let email = usernameTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
            guard let username = UserDefaults.standard.string(forKey: "username") else { return }
            let user = User(username: username, password: password)
           
            apiController.login(with: user, userType: userType, completion: { error in
                if let error = error {
                    NSLog("Error occured during sign in: \(error)")
                    
                    let alertController = UIAlertController(title: "Error Logging In", message: "Please try again.", preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Login", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    
                    
                } else {
                    DispatchQueue.main.async {
                    
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
        
        if userTypeSegmentedControl.selectedSegmentIndex == 0,
            loginType == .signUp {
            performSegue(withIdentifier: "UserOnboardingSegue", sender: sender)
        } else if userTypeSegmentedControl.selectedSegmentIndex == 1,
            loginType == .signUp {
            performSegue(withIdentifier: "InstructorOnboardingSegue", sender: sender)
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
            // TODO: need to add forgotPassword label?
        }
    }
    
    @IBAction func userTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            userType = .users
        } else {
            userType = .instructors
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserOnboarding" {
            if let userVC = segue.destination as? OnboardingViewController {
                userVC.viewDidLoad()
            }
        } else if segue.identifier == "InstructorOnboarding" {
            if let instructorVC = segue.destination as? InstructorOnboardingViewController  {
                instructorVC.viewDidLoad()
            }
        }
    }
}


