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
    @IBOutlet weak var stepOneTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var createButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        titleTextField.layer.cornerRadius = 8
        summaryTextView.layer.cornerRadius = 8
        stepOneTextField.layer.cornerRadius = 8
        categoryView.layer.cornerRadius = 8
        createButton.layer.cornerRadius = 8
    }

    // MARK: - IBActions
    @IBAction func createButtonTapped(_ sender: Any) {
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
