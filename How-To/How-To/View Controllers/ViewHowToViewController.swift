//
//  ViewHowToViewController.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class ViewHowToViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Properties
    var stepsStack = UIStackView()
    var apiController: APIController?
    var tutorial: Tutorial? {
       didSet {
           updateViews()
       }
    }
    
    #warning("Need to find a way to add these to the tutorial object itself")
    var steps: [TutorialSteps]?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSteps()
    }
    
    //view will appear
    
    // MARK: - Private Methods
    private func fetchSteps() {
        guard let tutorial = tutorial else { return }
        apiController?.fetchTutorialSteps(for: tutorial, completion: { (result) in
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
        summaryTextView.layer.cornerRadius = 8
    }
    
    private func updateViews() {
        guard let tutorial = tutorial else { return }
        title = tutorial.title
        if isViewLoaded {
            summaryTextView.text = "\(tutorial.summary)"
        }
    }
    
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
        let stackBottomConstraint = stepsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 2)
        
        NSLayoutConstraint.activate([stackLeadingConstraint, stackTopConstraint, stackTrailingConstraint, stackBottomConstraint])
        
        for step in steps {
            let stepNumberLabel = UILabel()
            stepNumberLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
            stepNumberLabel.text = "Step \(step.step_number)"
            stepNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stepNumberLabel)
            stepsStack.addArrangedSubview(stepNumberLabel)
            let instruction = UILabel()
            instruction.text = step.instructions
            instruction.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(instruction)
            stepsStack.addArrangedSubview(instruction)
        }
        
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
