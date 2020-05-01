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
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var summaryTextView: UITextView!
    @IBOutlet private weak var detailStackView: UIStackView!
    @IBOutlet private weak var contentView: UIView!
    
    // MARK: - Properties
    let apiController = APIController()
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
        let buttonBottomConstraint = addStepButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        let buttonHeightConstraint = addStepButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([stackLeadingConstraint, stackBottomConstraint, stackTrailingConstraint, buttonTopConstraint])
        NSLayoutConstraint.activate([buttonLeadingConstraint, buttonTrailingConstraint, buttonBottomConstraint, buttonHeightConstraint])
        
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
        guard let title = titleTextField.text, !title.isEmpty, let summary = summaryTextView.text, !summary.isEmpty else { return }
        
        let instructorID = UserDefaults.standard.integer(forKey: .userid)
        print(instructorID)
        let tut = Tut(title: title, summary: summary, instructor_id: instructorID)
        apiController.createTutorial(tutorial: tut) { tutorial, error in
            if let error = error {
                NSLog("Error creating tutorial \(error)")
            }
            
            if let tutorial = tutorial {
                print(tutorial)
            }
        }
        //navigationController?.popViewController(animated: true)
    }
}
