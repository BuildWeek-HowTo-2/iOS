//
//  CreateHowToViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class CreateHowToViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Properties
    var textFields: [UITextField] = []
    var textFieldsStack = UIStackView()
    var numberOfSteps = 1
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupViews()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        titleTextField.layer.cornerRadius = 8
        summaryTextView.layer.cornerRadius = 8
        
        textFieldsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldsStack)
        textFieldsStack.alignment = .fill
        textFieldsStack.axis = .vertical
        textFieldsStack.distribution = .fill
        textFieldsStack.spacing = 8
        
        let stackLeadingConstraint = textFieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        let stackBottomConstraint = textFieldsStack.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 8)
        let stackTrailingConstraint = textFieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        
        let addStepButton = UIButton(type: .system)
        addStepButton.setTitle("+ Add Step", for: .normal)
        addStepButton.addTarget(self, action: #selector(addTextField), for: .touchUpInside)
        addStepButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addStepButton)
        
        let buttonTopConstraint = addStepButton.topAnchor.constraint(equalTo: textFieldsStack.bottomAnchor, constant: 8)
        let buttonLeadingConstraint = addStepButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        let buttonTrailingConstraint = addStepButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        let buttonBottomConstraint = addStepButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 2)
        let buttonHeightConstraint = addStepButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([stackLeadingConstraint, stackBottomConstraint, stackTrailingConstraint, buttonTopConstraint, buttonLeadingConstraint, buttonTrailingConstraint, buttonBottomConstraint, buttonHeightConstraint])
        
        addTextField()
    }
    
    @objc private func addTextField() {
        let textField = UITextField()
        textField.placeholder = "  Step \(numberOfSteps)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.addSubview(textField)
        textFields.append(textField)
        textField.backgroundColor = UIColor(named: "Text Field Background Color")
        textField.layer.cornerRadius = 8
        textFieldsStack.addArrangedSubview(textField)
        numberOfSteps += 1
    }

    // MARK: - IBActions
    @IBAction func createButtonTapped(_ sender: Any) {
    }

}
