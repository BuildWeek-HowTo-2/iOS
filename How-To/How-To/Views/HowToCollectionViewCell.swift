//
//  HowToCollectionViewCell.swift
//  How-To
//
//  Created by Wyatt Harrell on 4/27/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import UIKit

class HowToCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Properties
     var tutorial: Tutorial? {
        didSet {
            updateViews()
        }
     }
    
    // MARK: - Private Methods
    private func updateViews() {
        guard let tutorial = tutorial else { return }
        titleLabel.text = tutorial.title
        captionLabel.text = tutorial.summary
        likesLabel.text = "\(tutorial.likes)"
    }
    
    // MARK: - IBActions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        guard let tutorial = tutorial else { return }
        Guide(tutorial: tutorial)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
        
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
    }
}
