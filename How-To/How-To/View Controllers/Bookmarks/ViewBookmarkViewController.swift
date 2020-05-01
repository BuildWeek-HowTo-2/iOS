//
//  ViewBookmarkViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/28/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class ViewBookmarkViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var detailStackView: UIStackView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var summaryView: UIView!
    
    // MARK: - Properties
    var steps: [TutorialSteps]? //TODO: NEED TO ADD THIS TO THE TUTORIAL OBJECT ITSELF
    var stepsStack = UIStackView()
    var apiController: APIController?
    var tutorial: Tutorial? {
       didSet {
           updateViews()
       }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupViews()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSteps()
    }
        
    // MARK: - Private Methods
    private func fetchSteps() {
        guard let tutorial = tutorial else { return }
        apiController?.fetchTutorialSteps(for: tutorial, completion: { result in
            do {
                let steps = try result.get()
                self.steps = steps
                DispatchQueue.main.async {
                    self.buildSteps()
                }
            } catch {
                if let error = error as? NetworkError {
                    NSLog("😂 \(error) error fetching steps")
                }
            }
        })
    }
    
    private func setupViews() {
        titleView.layer.cornerRadius = 8
        summaryView.layer.cornerRadius = 8
        titleView.layer.shadowColor = UIColor.lightGray.cgColor
        titleView.layer.shadowOpacity = 0.3
        titleView.layer.shadowOffset = .zero
        titleView.layer.shadowRadius = 5
        summaryView.layer.shadowColor = UIColor.lightGray.cgColor
        summaryView.layer.shadowOpacity = 0.3
        summaryView.layer.shadowOffset = .zero
        summaryView.layer.shadowRadius = 5
    }
    
    private func updateViews() {
        guard let tutorial = tutorial else { return }
        if isViewLoaded {
            titleLabel.text = tutorial.title
            summaryLabel.text = "\(tutorial.summary)"
        }
    }
    
    // swiftlint:disable function_body_length
    private func buildSteps() {
        guard let steps = steps else { return }
        stepsStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepsStack)
        stepsStack.alignment = .fill
        stepsStack.axis = .vertical
        stepsStack.distribution = .fill
        stepsStack.spacing = 16
        let stackLeadingConstraint = stepsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        let stackTopConstraint = stepsStack.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 8)
        let stackTrailingConstraint = stepsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        let stackBottomConstraint = stepsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        NSLayoutConstraint.activate([stackLeadingConstraint, stackTopConstraint, stackTrailingConstraint, stackBottomConstraint])
        for step in steps {
            let stepView = UIView()
            stepView.translatesAutoresizingMaskIntoConstraints = false
            stepView.backgroundColor = UIColor.white
            view.addSubview(stepView)
            stepView.layer.cornerRadius = 8
            stepView.layer.shadowColor = UIColor.lightGray.cgColor
            stepView.layer.shadowOpacity = 0.3
            stepView.layer.shadowOffset = .zero
            stepView.layer.shadowRadius = 5
            let stepNumberLabel = UILabel()
            stepNumberLabel.text = "\(step.step_number):"
            stepNumberLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
            stepNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stepNumberLabel)
            stepNumberLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
            let instruction = UILabel()
            instruction.numberOfLines = 0
            instruction.text = step.instructions
            instruction.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(instruction)
            let individualStepStack = UIStackView()
            individualStepStack.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(individualStepStack)
            individualStepStack.alignment = .fill
            individualStepStack.axis = .horizontal
            individualStepStack.distribution = .fillProportionally
            individualStepStack.spacing = 8
            individualStepStack.addArrangedSubview(stepNumberLabel)
            individualStepStack.addArrangedSubview(instruction)
            stepView.addSubview(individualStepStack)
            individualStepStack.topAnchor.constraint(equalTo: stepView.topAnchor, constant: 8).isActive = true
            individualStepStack.bottomAnchor.constraint(equalTo: stepView.bottomAnchor, constant: -8).isActive = true
            individualStepStack.leadingAnchor.constraint(equalTo: stepView.leadingAnchor, constant: 8).isActive = true
            individualStepStack.trailingAnchor.constraint(equalTo: stepView.trailingAnchor, constant: -8).isActive = true
            stepsStack.addArrangedSubview(stepView)
        }
    }
    // swiftlint:enable function_body_length
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - IBActions
    @IBAction func deleteTutorialTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Tutorial", message: "Are you sure you want to delete this tutorial?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete Tutorial", style: .destructive) { _ in
            guard let tutorial = self.tutorial else { return }

            self.apiController?.deleteTutorial(tutorial: tutorial, completion: { result in

                do {
                    let resultBool = try result.get()
                    if resultBool == true {
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                } catch {
                    if let error = error as? NetworkError {
                        NSLog("😂 \(error) error deleting tutorial")
                    }
                }
            })
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }

}
